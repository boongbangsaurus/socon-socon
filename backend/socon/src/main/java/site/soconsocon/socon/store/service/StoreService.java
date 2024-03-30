package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import site.soconsocon.socon.global.domain.ErrorCode;
import site.soconsocon.socon.global.exception.SoconException;

import site.soconsocon.socon.store.domain.dto.response.BusinessHourResponse;
import site.soconsocon.socon.store.domain.entity.feign.Member;
import site.soconsocon.socon.store.domain.dto.request.*;
import site.soconsocon.socon.store.domain.dto.response.FavoriteStoresListResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreInfoResponse;
import site.soconsocon.socon.store.domain.dto.response.StoreListResponse;
import site.soconsocon.socon.store.domain.entity.jpa.*;
import site.soconsocon.socon.store.exception.StoreErrorCode;
import site.soconsocon.socon.store.exception.StoreException;

import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;
import site.soconsocon.socon.store.domain.entity.jpa.FavStore;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessRegistration;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.feign.FeignServiceClient;
import site.soconsocon.socon.store.repository.*;

import java.sql.Time;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Slf4j
@RequiredArgsConstructor
@Service
public class StoreService {

    private final StoreRepository storeRepository;
    private final BusinessRegistrationRepository businessRegistrationRepository;
    private final BusinessHourRepository businessHourRepository;
    private final FavStoreRepository favStoreRepository;
    private final IssueRepository issueRepository;
    private final SoconRepository soconRepository;
    private final FeignServiceClient feignServiceClient;

    // 가게 정보 등록
    public void saveStore(AddStoreRequest request, int memberId) {

        //RegistrationNumber 조회
        BusinessRegistration businessRegistration = businessRegistrationRepository.findById(request.getRegistrationNumberId()).orElseThrow(() -> new StoreException(StoreErrorCode.REGISTRATION_NUMBER_NOT_FOUND));

        // 본인 소유의 사업자 등록 id가 아닌 경우
        if (!(businessRegistration.getMemberId().equals(memberId))) {
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
                .closingPlanned(null).isClosed(false).createdAt(LocalDate.now())
                .memberId(memberId)
                .businessRegistration(businessRegistration).build();

        // 중복체크 : store name, registrationNumber, lat, lng
        if (storeRepository.checkStoreDuplication(store.getName(), store.getBusinessRegistration().getId(), store.getLat(), store.getLng()) > 0) {
            throw new StoreException(StoreErrorCode.ALREADY_SAVED_STORE);
        }

        storeRepository.save(store);

        // businessHourList 저장
        List<BusinessHourRequest> businessHours = request.getBusinessHour();


        for (BusinessHourRequest businessHour : businessHours) {
            BusinessHour hour = new BusinessHour();
            if(businessHour.getIsWorking()){
                hour.setIsWorking(true);
                hour.setOpenAt(Time.valueOf(businessHour.getOpenAt() + ":00"));
                hour.setCloseAt(Time.valueOf(businessHour.getCloseAt() + ":00"));
            }
            else{
                hour.setIsWorking(false);
                hour.setOpenAt(null);
                hour.setCloseAt(null);
            }
            if(businessHour.getIsBreaktime()){
                hour.setIsBreaktime(true);
                hour.setBreaktimeStart(Time.valueOf(businessHour.getBreaktimeStart() + ":00"));
                hour.setBreaktimeEnd(Time.valueOf(businessHour.getBreaktimeEnd() + ":00"));
            }
            else{
                hour.setIsBreaktime(false);
                hour.setBreaktimeStart(null);
                hour.setBreaktimeEnd(null);
            }
            hour.setDay(businessHour.getDay());
            hour.setStore(store);

            businessHourRepository.save(hour);
        }
    }

    // 가게 정보 목록 조회
    public List<StoreListResponse> getStoreList(int memberId) {

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

        Store store = storeRepository.findById(storeId).orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));

        Member member = feignServiceClient.getMemberInfo(store.getMemberId());

        BusinessRegistration businessRegistration = store.getBusinessRegistration();
        Integer favoriteCount = favStoreRepository.countByStoreId(storeId);

        List<BusinessHour> businessHours = businessHourRepository.findBusinessHourResponseByStoreId(storeId);
        List<BusinessHourResponse> businessHourResponses = new ArrayList<>();
        for(BusinessHour businessHour : businessHours){
            businessHourResponses.add(BusinessHourResponse.builder()
                    .day(businessHour.getDay())
                    .isWorking(businessHour.getIsWorking())
                    .isBreaktime(businessHour.getIsBreaktime())
                    .openAt(businessHour.getOpenAt())
                    .closeAt(businessHour.getCloseAt())
                    .breaktimeStart(businessHour.getBreaktimeStart())
                    .breaktimeEnd(businessHour.getBreaktimeEnd())
                    .build());
        }



        return StoreInfoResponse.builder()
                .storeId(storeId)
                .name(store.getName())
                .category(store.getCategory())
                .image(store.getImage())
                .address(store.getAddress())
                .phoneNumber(store.getPhoneNumber())
                .businessHours(businessHourResponses)
                .introduction(store.getIntroduction())
                .closingPlanned(store.getClosingPlanned())
                .favoriteCount(favoriteCount)
                .createdAt(store.getCreatedAt())
                .registrationNumber(businessRegistration.getRegistrationNumber())
                .registrationAddress(businessRegistration.getRegistrationAddress())
                .owner(member.getName()) // 사업자 나중에 수정
                .build();
    }

    // 가게 정보 수정
    public void updateStoreInfo(Integer storeId, UpdateStoreInfoRequest request, int memberId) {

        var store = storeRepository.findById(storeId).orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
        if (!store.getMemberId().equals(memberId)) {
            // 본인 가게 아닐 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        } else {
            // 영업시간 수정
            List<BusinessHourRequest> requestBusinessHours = request.getBusinessHour(); // 요청 영업시간
            List<BusinessHour> savedBusinessHours = businessHourRepository.findByStoreId(storeId); // 저장되어있는 영업시간
            if (savedBusinessHours.isEmpty()) {
                // 저장된 값이 없을 경우
                for (BusinessHourRequest businessHour : requestBusinessHours) {
                    BusinessHour hour = new BusinessHour();
                    if (businessHour.getIsWorking()) {
                        hour.setIsWorking(true);
                        hour.setOpenAt(Time.valueOf(businessHour.getOpenAt()+":00"));
                        hour.setCloseAt(Time.valueOf(businessHour.getCloseAt()+":00"));
                    }
                    else{
                        hour.setIsWorking(false);
                        hour.setOpenAt(null);
                        hour.setCloseAt(null);
                    }
                    if (businessHour.getIsBreaktime()){
                        hour.setIsBreaktime(true);
                        hour.setBreaktimeStart(Time.valueOf(businessHour.getBreaktimeStart()+":00"));
                        hour.setBreaktimeEnd(Time.valueOf(businessHour.getBreaktimeEnd()+":00"));
                    }
                    else{
                        hour.setIsBreaktime(false);
                        hour.setBreaktimeStart(null);
                        hour.setBreaktimeEnd(null);
                    }

                    hour.setDay(businessHour.getDay());
                    hour.setStore(store);

                    businessHourRepository.save(hour);
                }

                List<BusinessHour> newBusinessHours = businessHourRepository.findByStoreId(storeId);

                Store savedStore = storeRepository.findById(storeId).orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
                savedStore.setBusinessHours(newBusinessHours);
                storeRepository.save(savedStore);
            } else {
                // 저장된 값이 있을 경우
                for (BusinessHourRequest businessHour : requestBusinessHours) {
                    BusinessHour matchedBusinessHour = savedBusinessHours.stream().filter(savedBusinessHour -> savedBusinessHour.getDay().equals(businessHour.getDay())).findFirst().orElse(null); // null일 경우

                    matchedBusinessHour.setIsWorking(businessHour.getIsWorking());
                    matchedBusinessHour.setOpenAt(Time.valueOf(businessHour.getOpenAt() + ":00"));
                    matchedBusinessHour.setCloseAt(Time.valueOf(businessHour.getCloseAt()+ ":00"));
                    matchedBusinessHour.setIsBreaktime(businessHour.getIsBreaktime());
                    matchedBusinessHour.setBreaktimeStart(Time.valueOf(businessHour.getBreaktimeStart()+ ":00"));
                    matchedBusinessHour.setBreaktimeEnd(Time.valueOf(businessHour.getBreaktimeEnd()+ ":00"));

                    businessHourRepository.save(matchedBusinessHour);

                }
            }

            store.setPhoneNumber(request.getPhoneNumber());
            store.setAddress(request.getAddress());
            store.setLat(request.getLat());
            store.setLng(request.getLng());
            store.setIntroduction(request.getIntroduction());

            storeRepository.save(store);

        }
    }

    // 가게 폐업 정보 수정
    public void updateClosedPlanned(Integer storeId, UpdateClosedPlannedRequest request, int memberId) {
        var store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));

        if (!Objects.equals(memberId, store.getMemberId())) {
            // 점포 소유주의 요청이 아닐 경우
            throw new SoconException(ErrorCode.FORBIDDEN);
        }
        if (store.getClosingPlanned() != null) {
            // 이미 폐업 신고가 되어 있는 경우
            throw new StoreException(StoreErrorCode.ALREADY_SET_CLOSE_PLAN);
        }
        LocalDate closedAt = LocalDate.now().plusDays(request.getCloseAfter());
        store.setClosingPlanned(closedAt);
        storeRepository.save(store);

        // 발행 중 소콘 발행 중지
        List<Issue> issues = issueRepository.findActiveIssuesByStoreId(storeId);
        for (Issue issue : issues) {
            issue.setStatus('I');
            issueRepository.save(issue);
            // 발행 된 소콘 중 사용되지 않은 소콘 마감기한 업데이트
            List<Socon> socons = soconRepository.getUnusedSoconByIssueId(issue.getId());
            for (Socon socon : socons) {
                socon.setExpiredAt(closedAt.atTime(23, 59, 59));
                soconRepository.save(socon);
            }
            // 폐업신고 시 알림 발송
            storeRepository.save(store);

        }
    }

    // 폐업 상태 업데이트
    public void updateCloseStore(){
        // 폐업 예정일 지정되어있지만 폐업하지 않은 가게 리스트
        List<Store> stores = storeRepository.storesScheduledToClose();

        for(Store store : stores){
            if(store.getClosingPlanned().isEqual(LocalDate.now())){
                // 오늘 일자와 같다면 폐업 처리
                store.setIsClosed(true);
                storeRepository.save(store);

                // 관심 가게 목록에서 삭제
                favStoreRepository.deleteByStoreId(store.getId());

                // 사용되지 않은 소콘 상태 업데이트
                List<Socon> socons = soconRepository.getSoconByStoreId(store.getId());
                for(Socon socon : socons ){
                    socon.setStatus("expired");
                    soconRepository.save(socon);
                }
            }
        }
    }

    // 관심가게 추가,취소
    public void favoriteStore(Integer storeId, int memberId) {

        Store store = storeRepository.findById(storeId)
                .orElseThrow(() -> new StoreException(StoreErrorCode.STORE_NOT_FOUND));
        if (Boolean.TRUE.equals(store.getIsClosed())) {
            // 폐업상태일 경우
            throw new SoconException(ErrorCode.BAD_REQUEST);
        }
        FavStore favStore = favStoreRepository.findByMemberIdAndStoreId(memberId, storeId);

        if (favStore != null) {
            // 이미 좋아요 한 경우
            favStoreRepository.delete(favStore);
        } else {
            favStoreRepository.save(FavStore.builder().memberId(memberId).storeId(storeId).build());
        }

    }

    // 관심 가게 목록 조회
    public List<FavoriteStoresListResponse> getFavoriteStoreList(int memberId) {

        List<FavoriteStoresListResponse> stores = new ArrayList<>();

        List<FavStore> favStores = favStoreRepository.findByMemberId(memberId);

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

    // 사업자 등록
    public void saveBusinessNumber(AddBusinessNumberRequest request, int memberId) {

        businessRegistrationRepository.save(BusinessRegistration.builder()
                .registrationNumber(request.getNumber())
                .registrationAddress(request.getAddress())
                .memberId(memberId)
                .build());
    }
}
