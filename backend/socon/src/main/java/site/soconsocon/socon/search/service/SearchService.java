package site.soconsocon.socon.search.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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
import site.soconsocon.socon.store.repository.jpa.StoreRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SearchService {
    private final SearchRepository searchRepository;
    private final FavStoreRepository favStoreRepository;
    public ArrayList<FoundStoreInfo> searchStores(SearchRequest searchRequest, Integer memberId){
        ArrayList<FoundStoreInfo> foundStoreInfoList = null;
        if(searchRequest.getSearchType() == SearchType.name){

        }
        else if(searchRequest.getSearchType() == SearchType.category){

        }
        else if (searchRequest.getSearchType() == SearchType.address) {
            Point location = new Point(Double.parseDouble(searchRequest.getLat()), Double.parseDouble(searchRequest.getLng()));
            Distance distance = new Distance(3);

            Page<StoreDocument> foundStores = searchRepository.findStoreDocumentsByLocationNear(location, distance)
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
            throw new SearchException(SearchErrorCode.INVALID_FORMAT);
        }
        return foundStoreInfoList;
    }
}
