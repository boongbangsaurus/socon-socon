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
import site.soconsocon.socon.search.domain.dto.response.FoundStoreInfo;
import site.soconsocon.socon.search.exception.SearchErrorCode;
import site.soconsocon.socon.search.exception.SearchException;
import site.soconsocon.socon.search.repository.elasticsearch.SearchRepository;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;
import site.soconsocon.socon.store.repository.jpa.FavStoreRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class SearchService {
    private final SearchRepository searchRepository;
    private final FavStoreRepository favStoreRepository;
    public ArrayList<FoundStoreInfo> searchStores(SearchRequest searchRequest, Integer memberId){
        ArrayList<FoundStoreInfo> foundStoreInfoList = new ArrayList<>();
        log.warn(searchRequest.toString());
        log.warn("memberId : "+memberId);
        Point location = new Point(Double.parseDouble(searchRequest.getLng()), Double.parseDouble(searchRequest.getLat()));
        Distance distance = new Distance(3);

        // default pagination value
        int page = searchRequest.getPage() == null ? 0 : searchRequest.getPage(); // Page number, 0-based
        int size = searchRequest.getSize() == null ? 0 : searchRequest.getSize(); // Number of items per page

        // Define sorting method
        Sort sort = null;
        if(searchRequest.getSort() == "distance"){
            sort = Sort.by(Sort.Direction.ASC, "location").and(Sort.by(Sort.Direction.ASC, "name")); // Assuming location field name is "location"
        } else if (searchRequest.getSort() == "name") {
            sort = Sort.by(Sort.Direction.ASC, "name"); // Assuming location field name is "location"
        }

        Pageable pageable = PageRequest.of(page, size, sort);
        Page<StoreDocument> foundStores = null;

        // create set for field isLike
        List<FavStore> favStoreList = favStoreRepository.findByMemberId(memberId);
        Set<Integer> favStoreIdList = favStoreList != null ? favStoreList.stream()
                .map(FavStore::getStoreId)
                .collect(Collectors.toSet()) : Collections.emptySet();

        if(searchRequest.getSearchType() == SearchType.address){
            foundStores = searchRepository.findStoreDocumentsByLocationNear(location, pageable);
        }
        else if(searchRequest.getSearchType() == SearchType.category ||searchRequest.getSearchType() == SearchType.name){
            foundStores = searchRepository.findStoreDocumentsByLocationNearAndContent(location, searchRequest.getSearchType().name(), searchRequest.getContent(), pageable);
        }else {
            log.error(SearchType.address.toString());
            throw new SearchException(SearchErrorCode.INVALID_FORMAT);
        }
        // generate FoundStoreInfo DTO
        for (StoreDocument storeDocument:foundStores) {
            boolean isLike = favStoreIdList.contains(storeDocument.getId());
            FoundStoreInfo storeInfo = FoundStoreInfo.builder()
                    .storeId(storeDocument.getId())
                    .name(storeDocument.getName())
                    .imageUrl(storeDocument.getImage())
                    .address(storeDocument.getAddress())
                    .category(storeDocument.getCategory())
                    .isLike(isLike)
                    .build();
            // filter favourites
            if(searchRequest.getIsFavoriteSearch()){
                if(isLike) foundStoreInfoList.add(storeInfo);
            }else {
                foundStoreInfoList.add(storeInfo);
            }
        }
        return foundStoreInfoList;
    }
}
