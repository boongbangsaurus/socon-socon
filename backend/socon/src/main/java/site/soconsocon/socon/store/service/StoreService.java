package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.GlobalException;
import site.soconsocon.socon.store.domain.dto.request.AddStoreRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateClosedPlannedRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateStoreInfoRequest;
import site.soconsocon.socon.store.domain.dto.response.FavoriteStoresListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;
import site.soconsocon.socon.store.domain.entity.jpa.RegistrationNumber;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;
import site.soconsocon.socon.store.repository.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@RequiredArgsConstructor
@Service
public class StoreService {

    private final StoreRepository storeRepository;
    private final RegistrationNumberRepository registrationNumberRepository;
    private final BusinessHourRepository businessHourRepository;
    private final FavStoreRepository favStoreRepository;
    private final IssueRepository issueRepository;

    // 가게 정보 등록
    public void saveStore(AddStoreRequest request, MemberRequest memberRequest) {

        //RegistrationNumber 조회
        RegistrationNumber registrationNumber = registrationNumberRepository.findById(request.getRegistrationNumberId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND, "" + request.getRegistrationNumberId()));

        // 본인 소유의 사업자 등록 id가 아닌 경우
        if(registrationNumber.getMemberId().equals(memberRequest.getMemberId())){
            throw new GlobalException(ErrorCode.FORBIDDEN,  "점포 소유자 아님");
        }

       var store = Store.builder()
            .name(request.getName())
            .category(request.getCategory())
            .image(request.getImage())
            .phoneNumber(request.getPhoneNumber())
            .address(request.getAddress())
            .lat(request.getLat())
            .lng(request.getLng())
            .introduction(request.getIntroduction())
            .closingPlanned(null)
            .isClosed(false)
            .createdAt(LocalDateTime.now())
            .memberId(memberRequest.getMemberId())
            .registrationNumber(registrationNumber)
            .build();

       // 중복체크 : store name, registrationNumber, lat, lng
       if(storeRepository.checkStoreDuplication(store.getName(), store.getRegistrationNumber().getId(), store.getLat(), store.getLng()) > 0){
           throw new StoreException (StoreErrorCode.ALREADY_SAVED_STORE, "" + store.getId());
       }
       else {
           storeRepository.save(store);
           var storeId = store.getId();

           // businessHourList 저장
           List<BusinessHour> businessHours = request.getBusinessHours();
           for (BusinessHour businessHour : businessHours) {
               businessHour.setStoreId(storeId);
               businessHourRepository.save(businessHour);
           }
           // 가게 정보에 businessHour 연결, 업데이트
           List<BusinessHour> savedBusinessHours = businessHourRepository.findByStoreId(storeId);

           Store savedStore = storeRepository.findById(storeId)
                   .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));
           savedStore.setBusinessHours(savedBusinessHours);
           storeRepository.save(savedStore);
       }
    }

    // 가게 정보 목록 조회
    public List<Store> getStoreList(MemberRequest request) {

        var memberId = request.getMemberId();

        List<Store> storeList = storeRepository.findStoresByMemberId(memberId);

        if(storeList.isEmpty()){
            return null;
        }
        else{
            return storeList;
        }
    }


    // 가게 정보 상세 조회
    public StoreInfoResponse getStoreInfo(Integer storeId) {

        Store store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));

        RegistrationNumber registrationNumber = store.getRegistrationNumber();

        Integer favoriteCount = favStoreRepository.countByStoreId(storeId);

            return StoreInfoResponse.builder()
                    .storeId(storeId)
                    .name(store.getName())
                    .category(store.getCategory())
                    .image(store.getImage())
                    .address(store.getAddress())
                    .phoneNumber(store.getPhoneNumber())
                    .businessHours(store.getBusinessHours())
                    .introduction(store.getIntroduction())
                    .closingPlanned(store.getClosingPlanned())
                    .favoriteCount(favoriteCount)
                    .createdAt(store.getCreatedAt())
                    .registrationNumber(registrationNumber.getRegistrationNumber())
                    .registrationAddress(registrationNumber.getRegistrationAddress())
                    .owner("temp_user") // 사업자 나중에 수정
                    .build();

    }

    // 가게 정보 수정
    public void updateStoreInfo(Integer storeId, UpdateStoreInfoRequest request, MemberRequest memberRequest) {

        var store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));

        if(store.getMemberId().equals(memberRequest.getMemberId())){
            // 본인 가게 아닐 경우
            throw new GlobalException(ErrorCode.FORBIDDEN, "점포 소유자 아님");
        }
        else{
            // 영업시간 수정
            List<BusinessHour> requestBusinessHours = request.getBusinessHours();
            List<BusinessHour> savedBusinessHours = businessHourRepository.findByStoreId(storeId);
            if(savedBusinessHours.isEmpty()){
               // 저장된 값이 없을 경우
                for (BusinessHour businessHour : requestBusinessHours) {
                    businessHour.setStoreId(storeId);
                    businessHourRepository.save(businessHour);
                }
                List<BusinessHour> newBusinessHours = businessHourRepository.findByStoreId(storeId);

                Store savedStore = storeRepository.findById(storeId)
                        .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));
                savedStore.setBusinessHours(newBusinessHours);
                storeRepository.save(savedStore);
            }
            else{
                // 저장된 값이 있을 경우
                for(BusinessHour businessHour : requestBusinessHours){
                    BusinessHour matchedBusinessHour = savedBusinessHours.stream()
                            .filter(savedBusinessHour -> savedBusinessHour.getDay().equals(businessHour.getDay()))
                            .findFirst()
                            .orElse(null); // 만약 값이 없으면 null 반환

                    matchedBusinessHour.setIsWorking(businessHour.getIsWorking());
                    matchedBusinessHour.setOpenAt(businessHour.getOpenAt());
                    matchedBusinessHour.setCloseAt(businessHour.getCloseAt());
                    matchedBusinessHour.setBreaktimeStart(businessHour.getBreaktimeStart());
                    matchedBusinessHour.setBreaktimeEnd(businessHour.getBreaktimeEnd());

                    businessHourRepository.save(matchedBusinessHour);
                    }
                }

            store.setImage(request.getImage());
            store.setPhoneNumber(request.getPhoneNumber());
            store.setAddress(request.getAddress());
            store.setLat(request.getLat());
            store.setLng(request.getLng());
            store.setIntroduction(request.getIntroduction());

            storeRepository.save(store);

        }
    }

    // 가게 폐업 정보 수정
    public Store updateClosedPlanned(Integer storeId, UpdateClosedPlannedRequest request, MemberRequest memberRequest) {
        var store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));

        if (memberRequest.getMemberId().equals(store.getMemberId())) {
             if(store.getClosingPlanned()!= null){
                 // 이미 폐업 신고가 되어 있는 경우
                 throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN, "" + storeId);
             }
             else{
                store.setClosingPlanned(LocalDateTime.now().plusDays(request.getCloseAfter()));
                storeRepository.save(store);
                return store;
             }
        }
        else{
            // 요청자의 memberId와 store의 memberId가 다를 경우
            throw new GlobalException(ErrorCode.FORBIDDEN,  "점포 소유자 아님" + memberRequest.getMemberId());
        }
    }

    // 관심 가게 추가, 취소
    public void favoriteStore(Integer storeId, MemberRequest memberRequest) {

        Store store = storeRepository.findById(storeId)
                        .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + storeId));
        if(!store.getIsClosed()){
            FavStore favStore = favStoreRepository.isExist(memberRequest.getMemberId(), storeId);
            if(favStore != null){
                // 이미 좋아요 한 경우
                favStoreRepository.delete(favStore);
            }
            else {
                favStoreRepository.save(FavStore.builder()
                        .memberId(memberRequest.getMemberId())
                        .storeId(storeId)
                        .build());
            }
        }
        else{
            // 폐업상태일 경우
            throw new GlobalException(ErrorCode.BAD_REQUEST, "폐업 점포");
        }
    }

    // 관심 가게 목록 조회
    public List<FavoriteStoresListResponse> getFavoriteStoreList(MemberRequest memberRequest) {

        List<FavoriteStoresListResponse> stores = new ArrayList<>();

        List<FavStore> favStores = favStoreRepository.findByMemberId(memberRequest.getMemberId());

        for (FavStore favStore : favStores) {
            Store store = storeRepository.findById(favStore.getStoreId())
                    .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND, "" + favStore.getStoreId()));
            FavoriteStoresListResponse res = FavoriteStoresListResponse.builder()
                    .storeId(store.getId())
                    .name(store.getName())
                    .image(store.getImage())
                    .mainMenu(issueRepository.findMainIssueNameByStoreId(store.getId()))
                    .build();
            stores.add(res);
        }

        return stores;
    }
}
