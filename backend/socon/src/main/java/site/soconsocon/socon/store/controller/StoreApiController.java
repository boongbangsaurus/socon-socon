package site.soconsocon.socon.store.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.request.*;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.dto.response.ItemListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.service.IssueService;
import site.soconsocon.socon.store.service.ItemService;
import site.soconsocon.socon.store.service.StoreService;
import site.soconsocon.utils.MessageUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/stores")
@RequiredArgsConstructor
public class StoreApiController {

    private final StoreService storeService;
    private final IssueService issueService;
    private final ItemService itemService;

    // 가게 정보 등록
    @PostMapping("")
    public ResponseEntity<Object> saveStore(
            @Valid
            @RequestBody
            AddStoreRequest request,
            MemberRequest memberRequest
    ) {
        storeService.saveStore(request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 점주 등록 가게 정보 목록 조회
    @GetMapping("")
    public ResponseEntity<Object> getStoreList(MemberRequest memberRequest) {


        return ResponseEntity.ok().body(MessageUtils.success(storeService.getStoreList(memberRequest)));
    }

    // 가게 정보 상세 조회
    @GetMapping("/{store_id}/info")
    public ResponseEntity<Object> getStoreInfo(
            @PathVariable("store_id") Integer storeId,
            MemberRequest memberRequest
    ){
        StoreInfoResponse store = storeService.getStoreInfo(storeId);
        List<IssueListResponse> issues = issueService.getIssueList(storeId, memberRequest);
        Map<String, Object> response = new HashMap<>();

        response.put("store", store);
        response.put("issues", issues);

        return ResponseEntity.ok().body(MessageUtils.success(response));
    }

    // 점주 가게 상세 정보 조회
    @GetMapping("/stores/{store_id}/manage/info")
    public ResponseEntity<Object> getDetailStoreInfo(
            @PathVariable("store_id") Integer storeId,
            MemberRequest memberRequest
    ){
        List<ItemListResponse> items = itemService.getItemList(storeId, memberRequest);
        List<IssueListResponse> issues = issueService.getIssueList(storeId, memberRequest);

        Map<String, Object> response = new HashMap<>();
        response.put("items", items);
        response.put("issues", issues);

        return ResponseEntity.ok().body(MessageUtils.success(response));
    }

    // 가게 정보 수정
    @PutMapping("/{store_id}/info")
    public ResponseEntity<Object> updateStoreInfo(
            UpdateStoreInfoRequest request,
            @PathVariable("store_id") Integer storeId,
            MemberRequest memberRequest
    ){
        storeService.updateStoreInfo(storeId, request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 가게 폐업 정보 업데이트
    @PutMapping("/{store_id}/manage/info")
    public ResponseEntity<Object> updateClosedPlanned(
            @PathVariable("store_id") Integer storeId,
            UpdateClosedPlannedRequest request,
            MemberRequest memberRequest
    ){
        storeService.updateClosedPlanned(storeId, request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success());
    }

    // 상품 정보 등록
    @PostMapping("/stores/{store_id}/items")
    public ResponseEntity<Object> saveStoreItem(
        @PathVariable("store_id") Integer storeId,
        @RequestBody AddItemRequest request,
        MemberRequest memberRequest
    ){

        itemService.saveItem(request, storeId, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 상품 정보 상세 조회
    @GetMapping("/stores/{store_id}/items/{item_id}")
    public ResponseEntity<Object> getDetailItemInfo(
        @PathVariable("store_id") Integer storeId,
        @PathVariable("item_id") Integer itemId,
        MemberRequest memberRequest
    ){
        return ResponseEntity.ok().body(MessageUtils.success(itemService.getDetailItemInfo(storeId, itemId, memberRequest)));
    }

    // 상품 발행 정보 등록
    @PostMapping("/stores/{store_id}/items/{item_id}")
    public ResponseEntity<Object> saveIssue(
        @PathVariable("store_id") Integer storeId,
        @PathVariable("item_id") Integer itemId,
        @RequestBody AddIssueRequest request,
        MemberRequest memberRequest
    ){
        issueService.saveIssue(request, storeId, itemId, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 관심 가게 추가, 취소
    @PostMapping("/favorite/{store_id}")
    public ResponseEntity<Object> favoriteStore(
        @PathVariable("store_id") Integer storeId,
        MemberRequest memberRequest
    ){
        storeService.favoriteStore(storeId, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 관심 가게 목록 조회
    @GetMapping("/favorite")
    public ResponseEntity<Object> getFavoriteList(
        MemberRequest memberRequest
    ){

        return ResponseEntity.ok().body(MessageUtils.success(storeService.getFavoriteStoreList(memberRequest)));
    }

}
