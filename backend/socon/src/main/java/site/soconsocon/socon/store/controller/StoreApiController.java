package site.soconsocon.socon.store.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.request.*;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.dto.response.ItemListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
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

    private StoreService storeService;
    private IssueService issueService;
    private ItemService itemService;


    // 가게 정보 등록
    @PostMapping("")
    public ResponseEntity saveStore(
            @Valid
            @RequestBody
            AddStoreRequest request,
            MemberRequest memberRequest
    ) {
        return ResponseEntity.created(null).body(MessageUtils.success(null));

    }

    // 가게 정보 목록 조회
    @GetMapping("")
    public ResponseEntity getStoreList(MemberRequest memberRequest) {

        List<Store> stores = storeService.getStoreList(memberRequest);

        if(stores.isEmpty()){
            Map<String, Object> response = new HashMap<>();
            response.put("stores", stores);
            return ResponseEntity.ok().body(MessageUtils.success(response));
        }
        else{
            return ResponseEntity.ok().body(MessageUtils.success(stores));
        }
    }
    // 가게 정보 상세 조회
    @GetMapping("/{store_id}/info")
    public ResponseEntity getStoreInfo(
            @PathVariable("store_id") Integer storeId,
            MemberRequest memberRequest
    ){
        StoreInfoResponse store = storeService.getStoreInfo(storeId);
        List<IssueListResponse> issues = issueService.getIssueList(storeId, memberRequest);
        Map<String, Object> response = new HashMap<>();

        if(issues.isEmpty()){
            response.put("store", store);
            response.put("issues", null);
            return ResponseEntity.ok().body(MessageUtils.success(store));
        }
        else{
            response.put("store", store);
            response.put("issues", issues);

            return ResponseEntity.ok().body(MessageUtils.success(response));
        }
    }

    // 점주 가게 상세 정보 조회
    @GetMapping("/stores/{store_id}/manage/info")
    public ResponseEntity getDetailStoreInfo(
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
    public ResponseEntity updateStoreInfo(
            UpdateStoreInfoRequest request,
            @PathVariable("store_id") Integer storeId,
            MemberRequest memberRequest
    ){

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 가게 폐업 정보 업데이트
    @PutMapping("/{store_id}/manage/info")
    public ResponseEntity updateClosedPlanned(
            @PathVariable("store_id") Integer storeId,
            UpdateClosedPlannedRequest request,
            MemberRequest memberRequest
    ){

        Store store = storeService.updateClosedPlanned(storeId, request, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(store.getClosingPlanned()));
    }

    // 상품 정보 등록
    @PostMapping("/stores/{store_id}/items")
    public ResponseEntity saveStoreItem(
        @PathVariable("store_id") Integer storeId,
        @RequestBody AddItemRequest request,
        MemberRequest memberRequest
    ){

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 상품 정보 상세 조회
    @GetMapping("/stores/{store_id}/items/{item_id}")
    public ResponseEntity getDetailItemInfo(
        @PathVariable("store_id") Integer storeId,
        @PathVariable("item_id") Integer itemId,
        MemberRequest memberRequest
    ){
        Item item  = itemService.getDetailItemInfo(storeId, itemId, memberRequest);

        return ResponseEntity.ok().body(MessageUtils.success(item));
    }

    // 상품 발행 정보 등록
    @PostMapping("/stores/{store_id}/items/{item_id}")
    public ResponseEntity saveIssue(
        @PathVariable("store_id") Integer storeId,
        @PathVariable("item_id") Integer itemId,
        @RequestBody AddIssueRequest request,
        MemberRequest memberRequest
    ){

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }



}
