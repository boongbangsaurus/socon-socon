package site.soconsocon.socon.store.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.soconsocon.socon.store.domain.dto.request.*;
import site.soconsocon.socon.store.domain.dto.response.IssueListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.service.IssueService;
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

        return ResponseEntity.ok().body(MessageUtils.success(stores));

    }

    // 가게 정보 상세 조회
    @GetMapping("/{store_id}/info")
    public ResponseEntity getStoreInfo(
            @PathVariable("store_id") Integer storeId
    ){
        StoreInfoResponse store = storeService.getStoreInfo(storeId);
        List<IssueListResponse> issues = issueService.getIssueList(storeId);

        Map<String, Object> response = new HashMap<>();
        response.put("store", store);
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
        // 요청자의 memberId가 owner의 id와 일치하는지 확인 필요

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



}
