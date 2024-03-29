package site.soconsocon.socon.search.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import site.soconsocon.socon.search.domain.dto.request.SearchRequest;
import site.soconsocon.socon.search.domain.dto.response.FoundStoreInfo;
import site.soconsocon.socon.search.service.SearchService;
import site.soconsocon.utils.MessageUtils;

import java.util.List;

@RestController
@RequestMapping("/api/v1/search")
@RequiredArgsConstructor
public class SearchController {

    private final SearchService searchService;
    @PostMapping("/detail")
    public ResponseEntity getStoresDetail(@RequestBody SearchRequest searchRequest){
        List<FoundStoreInfo> storeInfoList = searchService.searchStores(searchRequest);
        return ResponseEntity.ok().body(MessageUtils.success());
    }

}
