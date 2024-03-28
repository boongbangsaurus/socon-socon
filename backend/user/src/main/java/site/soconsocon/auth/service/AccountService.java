package site.soconsocon.auth.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.auth.domain.dto.request.DepositRequestDto;
import site.soconsocon.auth.domain.dto.request.WithdrawRequestDto;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.exception.AccountException;
import site.soconsocon.auth.exception.ErrorCode;
import site.soconsocon.auth.exception.MemberException;
import site.soconsocon.auth.repository.MemberRepository;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final MemberRepository memberRepository;

    /**
     * 입금
     *
     * @param depositRequestDto
     * @throws MemberException
     */
    public void deposit(DepositRequestDto depositRequestDto) throws MemberException, AccountException {
        Member member = memberRepository.findMemberById(depositRequestDto.getMemberId()).orElseThrow(
                () -> new MemberException(ErrorCode.USER_NOT_FOUND)
        );
        int soconMoney = member.getSoconMoney(); //현재 보유하고 있는 소콘머니
        int depositMoney = depositRequestDto.getMoney(); //충전할 소콘머니

        memberRepository.chargeSoconMoney(depositRequestDto.getMemberId(), depositMoney); //증가

    }


    public void withdraw(WithdrawRequestDto withdrawRequestDto) throws MemberException, AccountException {
        Member member = memberRepository.findMemberById(withdrawRequestDto.getMemberId()).orElseThrow(
                () -> new MemberException(ErrorCode.USER_NOT_FOUND)
        );
        int soconMoney = member.getSoconMoney(); //현재 보유하고 있는 소콘머니
        int depositMoney = withdrawRequestDto.getMoney(); //출금할 소콘머니

        if(soconMoney < depositMoney) {
            throw new AccountException(ErrorCode.NO_MONEY); //돈 없음
        }
        memberRepository.withdrawSoconMoney(withdrawRequestDto.getMemberId(), depositMoney); //증가

    }

}
