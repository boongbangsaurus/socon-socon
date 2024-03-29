package site.soconsocon.socon.search.service;

import org.springframework.stereotype.Service;
import site.soconsocon.socon.search.domain.dto.request.SearchRequest;
import site.soconsocon.socon.search.domain.dto.response.FoundStoreInfo;

import java.util.ArrayList;

@Service
public class SearchService {
    public ArrayList<FoundStoreInfo> searchStores(SearchRequest searchRequest){
        return new ArrayList<>();
    }
}
