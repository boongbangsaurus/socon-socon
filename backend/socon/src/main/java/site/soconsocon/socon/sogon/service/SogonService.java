package site.soconsocon.socon.sogon.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.global.exception.ForbiddenException;
import site.soconsocon.socon.global.exception.badrequest.InvalidSoconException;
import site.soconsocon.socon.global.exception.notfound.SoconNotFoundException;
import site.soconsocon.socon.sogon.domain.dto.request.AddSogonRequest;
import site.soconsocon.socon.sogon.domain.entity.Sogon;
import site.soconsocon.socon.sogon.repository.SogonRepository;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.entity.jpa.Socon;
import site.soconsocon.socon.store.repository.SoconRepository;

import java.time.LocalDateTime;
import java.util.Objects;

@RequiredArgsConstructor
@Service
public class SogonService {

    private final SoconRepository soconRepository;
    private final SogonRepository sogonRepository;


    public void addSogon(AddSogonRequest request, MemberRequest memberRequest) {

        // 유효한 소콘인지 체크
        Socon socon = soconRepository.findById(request.getSoconId())
                .orElseThrow(() -> new SoconNotFoundException("존재하지 않는 소콘, socon_id : " + request.getSoconId()));
        if(socon.getIsUsed()){
            // 이미 사용된 소콘
            throw new InvalidSoconException("사용된 소콘, socon_id : " + request.getSoconId());
        }
        if(socon.getExpiredAt().isBefore(LocalDateTime.now())){
            // 이미 만료된 소콘
            throw new InvalidSoconException("만료된 소콘, socon_id : " + request.getSoconId());
        }
        if(sogonRepository.countBySoconId(request.getSoconId()) > 0){
            // 이미 소곤에 등록된 소콘
            throw new InvalidSoconException("이미 소곤에 등록된 소콘, socon_id : " + request.getSoconId());
        }
        if(!Objects.equals(socon.getMemberId(), memberRequest.getMemberId())){
            // 본인 소유 소콘이 아님
            throw new ForbiddenException("본인 소유 소콘이 아님, socon_id : " + request.getSoconId() + " member_id : " + memberRequest.getMemberId());
        }

        LocalDateTime now = LocalDateTime.now();
        if(now.isAfter(socon.getExpiredAt())){
            now = socon.getExpiredAt();
        }
        else{
            now = now.plusHours(24);
        }

        Sogon sogon = new Sogon().builder()
                .title(request.getTitle())
                .content(request.getContent())
                .createdDate(LocalDateTime.now())
                .isExpired(now)
                .isPicked(false)
                .image1(request.getImage1())
                .image2(request.getImage2())
                .lat(request.getLat())
                .lng(request.getLng())
                .build();
        sogonRepository.save(sogon);
    }
}
