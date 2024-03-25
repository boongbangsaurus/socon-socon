package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;

import site.soconsocon.socon.store.domain.dto.request.AddStoreRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateClosedPlannedRequest;
import site.soconsocon.socon.store.domain.dto.request.UpdateStoreInfoRequest;
import site.soconsocon.socon.store.domain.dto.response.FavoriteStoresListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.*;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;

import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;
import site.soconsocon.socon.store.domain.entity.jpa.RegistrationNumber;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.repository.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@RequiredArgsConstructor
@Service
public class StoreService {

    private final StoreRepository storeRepository;
    private final RegistrationNumberRepository registrationNumberRepository;
    private final BusinessHourRepository businessHourRepository;
    private final FavStoreRepository favStoreRepository;
    private final IssueRepository issueRepository;
    private final SoconRepository soconRepository;


    // 가게 정보 등록
    public void saveStore(AddStoreRequest request, MemberRequest memberRequest) {

        //RegistrationNumber 조회
        RegistrationNumber registrationNumber = registrationNumberRepository.findById(request.getRegistrationNumberId())
                .orElseThrow(() -> new StoreException(StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND));

        // 본인 소유의 사업자 등록 id가 아닌 경우

        if (registrationNumber.getMemberId().equals(memberRequest.getMemberId())) {
            throw new SoconException(ErrorCode.FORBIDDEN);
        }

        Store store = Store.builder()
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
        if (storeRepository.checkStoreDuplication(store.getName(), store.getRegistrationNumber().getId(), store.getLat(), store.getLng()) > 0) {
            throw new StoreException(StoreErrorCode.ALREADY_SAVED_STORE);
        }
        storeRepository.save(store);

        // businessHourList 저장
        List<BusinessHour> businessHours = request.getBusinessHours();
        for (BusinessHour businessHour : businessHours) {
            businessHourRepository.save(BusinessHour.builder()
                    .day(businessHour.getDay())
                    .isWorking(businessHour.getIsWorking())
                    .openAt(businessHour.getOpenAt())
                    .closeAt(businessHour.getCloseAt())
                    .breaktimeStart(businessHour.getBreaktimeStart())
                    .breaktimeEnd(businessHour.getBreaktimeEnd())
                    .store(store)
                    .build());
        }

    }

    // 가게 정보 목록 조회
    public List<StoreListResponse> getStoreList(MemberRequest request) {

        Integer memberId = request.getMemberId();
        List<Store> stores = storeRepository.findStoresByMemberId(memberId);
        List<StoreListResponse> storeList = new ArrayList<>();
        for (Store store : stores) {
            storeList.add(StoreListResponse.builder()
                    .id(store.getId())
                    .name(store.getName())
                    .category(store.getCategory())
                    .image(store.getImage())
                    .createdAt(store.getCreatedAt())
                    .build());
        }
        return storeList;
    }

    // 가게 정보 상세 조회
    public StoreInfoResponse getStoreInfo(Integer storeId) {

        Store store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));

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
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));


        if (store.getMemberId().equals(memberRequest.getMemberId())) {
            // 본인 가게 아닐 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        } else {
            // 영업시간 수정
            List<BusinessHour> requestBusinessHours = request.getBusinessHours();

            List<BusinessHour> savedBusinessHours = businessHourRepository.findByStoreId(storeId);

            if(requestBusinessHours.isEmpty()){
               // 저장된 값이 없을 경우
                for (BusinessHour businessHour : requestBusinessHours) {
                    businessHour.setStore(store);
                    businessHourRepository.save(businessHour);
                }
                List<BusinessHour> newBusinessHours = businessHourRepository.findByStoreId(storeId);

                Store savedStore = storeRepository.findById(storeId)
                        .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
                savedStore.setBusinessHours(newBusinessHours);
                storeRepository.save(savedStore);
            } else {
                // 저장된 값이 있을 경우
                for (BusinessHour businessHour : requestBusinessHours) {
                    BusinessHour matchedBusinessHour = savedBusinessHours.stream()
                            .filter(savedBusinessHour -> savedBusinessHour.getDay().equals(businessHour.getDay()))
                            .findFirst()
                            .orElse(null); // null일 경우

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
    public void updateClosedPlanned(Integer storeId, UpdateClosedPlannedRequest request, MemberRequest memberRequest) {
        var store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));

        if (!Objects.equals(memberRequest.getMemberId(), store.getMemberId())) {

        if (memberRequest.getMemberId() == store.getMemberId()) {
             if(store.getClosingPlanned()!= null){
                 // 이미 폐업 신고가 되어 있는 경우
                 throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN);
             }
             else{
                store.setClosingPlanned(LocalDateTime.now().plusDays(request.getCloseAfter()));
                storeRepository.save(store);
             }
        }
        else{

            // 요청자의 memberId와 store의 memberId가 다를 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        }
        if (store.getClosingPlanned() != null) {
            // 이미 폐업 신고가 되어 있는 경우
            throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN);
        }
        LocalDateTime closingPlannedAt = LocalDateTime.now().plusDays(request.getCloseAfter());

        store.setClosingPlanned(closingPlannedAt);

        // 발행 중 소콘 발행 중지
        List<Issue> issues = issueRepository.findActiveIssuesByStoreId(storeId);
        for (Issue issue : issues) {
            issue.setStatus('I');
            issueRepository.save(issue);
            // 발행 된 소콘 중 사용되지 않은 소콘 마감기한 업데이트
            List<Socon> socons = soconRepository.getUnusedSoconByIssueId(issue.getId());
            for (Socon socon : socons) {
                socon.setExpiredAt(closingPlannedAt);
                soconRepository.save(socon);
            }
        }

        // 폐업신고 시 알림 발송

        storeRepository.save(store);

    }
        }

    public void addFavoriteStore(Integer storeId, MemberRequest memberRequest) {

        Store store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
        if (store.getIsClosed()) {
            // 폐업상태일 경우
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
        FavStore favStore = favStoreRepository.findByMemberIdAndStoreId(memberRequest.getMemberId(), storeId);

        if (favStore != null) {
            // 이미 좋아요 한 경우
            favStoreRepository.delete(favStore);
        } else {
            favStoreRepository.save(FavStore.builder()
                    .memberId(memberRequest.getMemberId())
                    .storeId(storeId)
                    .build());
        }

    }

    // 관심 가게 목록 조회
    public List<FavoriteStoresListResponse> getFavoriteStoreList(MemberRequest memberRequest) {

        List<FavoriteStoresListResponse> stores = new ArrayList<>();

        List<FavStore> favStores = favStoreRepository.findByMemberId(memberRequest.getMemberId());

        for (FavStore favStore : favStores) {
            Store store = storeRepository.findById(favStore.getStoreId())
                    .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
            stores.add(FavoriteStoresListResponse.builder()
                    .id(store.getId())
                    .name(store.getName())
                    .image(store.getImage())
                    .mainMenu(issueRepository.findMainIssueNameByStoreId(store.getId()))
                    .build());

        }
        return stores;
    }
}
