package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.store.domain.dto.request.AddStoreRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateClosedPlannedRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateStoreInfoRequest;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;
import site.soconsocon.socon.store.domain.entity.jpa.RegistrationNumber;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.repository.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;


@RequiredArgsConstructor
@Service
public class StoreService {

    private final StoreRepository storeRepository;
    private final RegistrationNumberRepository registrationNumberRepository;
    private final BusinessHourRepository businessHourRepository;
    private final FavStoreRepository favStoreRepository;

    // 가게 정보 등록
    public Store saveStore(AddStoreRequest request, MemberRequest memberRequest) {
        
        //RegistrationNumber 조회
        RegistrationNumber registrationNumber = registrationNumberRepository.findById(request.getRegistrationNumberId())
                .orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + request.getRegistrationNumberId()));

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
                .orElseThrow(() -> new RuntimeException("Store not found, store_id : " + storeId));
        savedStore.setBusinessHours(savedBusinessHours);
        storeRepository.save(savedStore);

        return savedStore;

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

        var store = storeRepository.findById(storeId);

        RegistrationNumber registrationNumber = store.get().getRegistrationNumber();

        Integer favoriteCount = favStoreRepository.countByStoreId(storeId);

        if(store.isEmpty()){
            return null;
        }
        else{
            return StoreInfoResponse.builder()
                    .storeId(storeId)
                    .name(store.get().getName())
                    .category(store.get().getCategory())
                    .image(store.get().getImage())
                    .address(store.get().getAddress())
                    .phoneNumber(store.get().getPhoneNumber())
                    .businessHours(store.get().getBusinessHours())
                    .introduction(store.get().getIntroduction())
                    .closingPlanned(store.get().getClosingPlanned())
                    .favoriteCount(favoriteCount)
                    .createdAt(store.get().getCreatedAt())
                    .registrationNumber(registrationNumber.getRegistrationNumber())
                    .registrationAddress(registrationNumber.getRegistrationAddress())
                    .owner("temp_user") // 사업자 나중에 수정

                    .build();
        }
    }
    public Store updateStoreInfo(Integer storeId, UpdateStoreInfoRequest request) {

        var store = storeRepository.findById(storeId).orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + storeId));

        // 영업시간 수정
        List<BusinessHour> requestBusinessHours = request.getBusinessHours();
        List<BusinessHour> savedBusinessHours = businessHourRepository.findByStoreId(storeId);
        if(requestBusinessHours.isEmpty()){
           // 저장된 값이 없을 경우
            for (BusinessHour businessHour : requestBusinessHours) {
                businessHour.setStoreId(storeId);
                businessHourRepository.save(businessHour);
            }
            List<BusinessHour> newBusinessHours = businessHourRepository.findByStoreId(storeId);

            Store savedStore = storeRepository.findById(storeId)
                    .orElseThrow(() -> new RuntimeException("Store not found, store_id : " + storeId));
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

        return store;
    }

    // 가게 폐업 정보 수정
    public Store updateClosedPlanned(Integer storeId, UpdateClosedPlannedRequest request, MemberRequest memberRequest) {
        var store = storeRepository.findById(storeId).orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + storeId));

        if (memberRequest.getMemberId() == store.getMemberId()) {
            store.setClosingPlanned(LocalDateTime.now().plusDays(request.getCloseAfter()));
            storeRepository.save(store);
            return store;
        }
        else{
            // 에러 처리 추가
            return null;
        }


    }
}
