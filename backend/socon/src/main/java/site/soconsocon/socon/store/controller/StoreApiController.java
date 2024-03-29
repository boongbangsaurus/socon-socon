package site.soconsocon.socon.store.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
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
            @RequestHeader("X-Authorization-Id") int memberId
    ) {

        storeService.saveStore(request, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 점주 등록 가게 정보 목록 조회
    @GetMapping("")
    public ResponseEntity<Object> getStoreList(@RequestHeader("X-Authorization-Id") int memberId) {

        return ResponseEntity.ok().body(MessageUtils.success(storeService.getStoreList(memberId)));
    }

    // 가게 정보 상세 조회
    @GetMapping("/{store_id}/info")
    public ResponseEntity<Object> getStoreInfo(
            @PathVariable("store_id") Integer storeId
    ) {
        StoreInfoResponse store = storeService.getStoreInfo(storeId);
        List<IssueListResponse> issues = issueService.getIssueList(storeId);
        Map<String, Object> response = new HashMap<>();

        response.put("store", store);
        response.put("issues", issues);

        return ResponseEntity.ok().body(MessageUtils.success(response));
    }

    // 점주 가게 상세 정보 조회`
    @GetMapping("/{store_id}/manage/info")
    public ResponseEntity<Object> getDetailStoreInfo(
            @PathVariable("store_id") Integer storeId,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        List<ItemListResponse> items = itemService.getItemList(storeId, memberId);
        List<IssueListResponse> issues = issueService.getIssueList(storeId);

        Map<String, Object> response = new HashMap<>();
        response.put("items", items);
        response.put("issues", issues);

        return ResponseEntity.ok().body(MessageUtils.success(response));
    }

    // 가게 정보 수정
    @PutMapping("/{store_id}/info")
    public ResponseEntity<Object> updateStoreInfo(
            @RequestBody UpdateStoreInfoRequest request,
            @PathVariable("store_id") Integer storeId,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {

        storeService.updateStoreInfo(storeId, request, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null));
    }

    // 가게 폐업 정보 업데이트
    @PutMapping("/{store_id}/manage/info")
    public ResponseEntity<Object> updateClosedPlanned(
            @PathVariable("store_id") Integer storeId,
            UpdateClosedPlannedRequest request,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        storeService.updateClosedPlanned(storeId, request, memberId);

        return ResponseEntity.ok().body(MessageUtils.success());
    }

    // 상품 정보 등록
    @PostMapping("/{store_id}/items")
    public ResponseEntity<Object> saveStoreItem(
            @PathVariable("store_id") Integer storeId,
            @RequestBody AddItemRequest request,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {

        itemService.saveItem(request, storeId, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null, "201 CREATED", null));
    }

    // 상품 정보 상세 조회
    @GetMapping("/{store_id}/items/{item_id}")
    public ResponseEntity<Object> getDetailItemInfo(
            @PathVariable("store_id") Integer storeId,
            @PathVariable("item_id") Integer itemId,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        return ResponseEntity.ok().body(MessageUtils.success(itemService.getDetailItemInfo(storeId, itemId, memberId)));
    }

    // 상품 발행 정보 등록
    @PostMapping("/{store_id}/items/{item_id}")
    public ResponseEntity<Object> saveIssue(
            @PathVariable("store_id") Integer storeId,
            @PathVariable("item_id") Integer itemId,
            @RequestBody AddIssueRequest request,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        issueService.saveIssue(request, storeId, itemId, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null, "201 CREATED", null));
    }

    // 관심 가게 추가, 취소
    @PostMapping("/favorite/{store_id}")
    public ResponseEntity<Object> favoriteStore(
            @PathVariable("store_id") Integer storeId,
            @RequestHeader("X-Authorization-Id") int memberId
    ) {
        storeService.favoriteStore(storeId, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null, "204 NO CONTENT", null));
    }

    // 관심 가게 목록 조회
    @GetMapping("/favorite")
    public ResponseEntity<Object> getFavoriteList(
            @RequestHeader("X-Authorization-Id") int memberId
    ) {

        return ResponseEntity.ok().body(MessageUtils.success(storeService.getFavoriteStoreList(memberId)));
    }

    // 사업자 번호 등록
    @PostMapping("/business")
    public ResponseEntity<Object> saveBusinessNumvber(
            @Valid
            @RequestBody
            AddBusinessNumberRequest request,
            @RequestHeader("X-Authorization-Id") int memberId
    ){

        storeService.saveBusinessNumber(request, memberId);

        return ResponseEntity.ok().body(MessageUtils.success(null, "201 CREATED", null));
    }

    @GetMapping("/test")
    public ResponseEntity<Object> test(){
        return ResponseEntity.ok().body(MessageUtils.success("test"));
    }
}
