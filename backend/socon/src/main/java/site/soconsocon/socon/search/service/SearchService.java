package site.soconsocon.socon.search.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Point;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.search.domain.document.StoreDocument;
import site.soconsocon.socon.search.domain.dto.common.SearchType;
import site.soconsocon.socon.search.domain.dto.request.SearchRequest;
import site.soconsocon.socon.search.domain.dto.request.StoreCreateDocument;
import site.soconsocon.socon.search.domain.dto.response.FoundStoreInfo;
import site.soconsocon.socon.search.exception.SearchErrorCode;
import site.soconsocon.socon.search.exception.SearchException;
import site.soconsocon.socon.search.repository.elasticsearch.SearchRepository;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;
import site.soconsocon.socon.store.repository.jpa.FavStoreRepository;
import site.soconsocon.socon.store.repository.jpa.StoreRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class SearchService {
    private final SearchRepository searchRepository;
    private final FavStoreRepository favStoreRepository;
    public ArrayList<FoundStoreInfo> searchStores(SearchRequest searchRequest, Integer memberId){
        ArrayList<FoundStoreInfo> foundStoreInfoList = null;
        log.warn(searchRequest.toString());
        log.warn("memberId : "+memberId);
        if(searchRequest.getSearchType() == SearchType.name){

        }
        else if(searchRequest.getSearchType() == SearchType.category){

        }
        else if (searchRequest.getSearchType() == SearchType.address) {
            Point location = new Point(Double.parseDouble(searchRequest.getLng()), Double.parseDouble(searchRequest.getLat()));
            Distance distance = new Distance(3);
            // default pagination value
            int page = 0; // Page number, 0-based
            int size = 10; // Number of items per page
            Pageable pageable = PageRequest.of(page, size);
            // Define sorting by distance
            Sort sort = Sort.by(Sort.Direction.ASC, "location").and(Sort.by(Sort.Direction.ASC, "name")); // Assuming location field name is "location"

            Page<StoreDocument> foundStores = searchRepository.findStoreDocumentsByLocationNear(location, distance, pageable)
                    .orElseThrow(() -> new SearchException(SearchErrorCode.SEARCH_FAIL));

            List<FavStore> favStoreList = favStoreRepository.findByMemberId(memberId);
            Set<Integer> favStoreIdList = favStoreList != null ? favStoreList.stream()
                    .map(FavStore::getStoreId)
                    .collect(Collectors.toSet()) : Collections.emptySet();

            foundStoreInfoList = foundStores.getContent().stream()
                    .map(storeDocument -> {
                        boolean isLike = favStoreIdList.contains(storeDocument.getId()); // 람다 내부에서 선언
                        return FoundStoreInfo.builder()
                                .storeId(storeDocument.getId())
                                .name(storeDocument.getName())
                                .imageUrl(storeDocument.getImage())
                                .address(storeDocument.getAddress())
                                .category(storeDocument.getCategory())
                                .isLike(isLike)
                                .build();
                    })
                    .collect(Collectors.toCollection(ArrayList::new));
        } else {
            log.error(SearchType.address.toString());
            throw new SearchException(SearchErrorCode.INVALID_FORMAT);
        }
        return foundStoreInfoList;
    }

    public void addStores(StoreCreateDocument storeCreateDocument) {
        try{
            searchRepository.save(storeCreateDocument.toDocument());
        } catch (RuntimeException e){
            throw new SearchException(SearchErrorCode.SAVE_DOCUMENT_FAIL);
        }
    }
}
