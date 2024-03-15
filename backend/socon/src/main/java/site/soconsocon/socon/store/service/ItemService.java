package site.soconsocon.socon.store.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.socon.store.domain.dto.request.AddItemRequest;
import site.soconsocon.socon.store.domain.dto.request.MemberRequest;
import site.soconsocon.socon.store.domain.entity.jpa.Item;
import site.soconsocon.socon.store.domain.entity.jpa.Store;
import site.soconsocon.socon.store.repository.ItemRepository;
import site.soconsocon.socon.store.repository.StoreRepository;

@RequiredArgsConstructor
@Service
public class ItemService {

    private final StoreRepository storeRepository;
    private final ItemRepository itemRepository;

    // 상품 정보 등록
    public void saveItem(AddItemRequest request, Integer storeId, MemberRequest memberRequest) {

        Store savedStore = storeRepository.findById(storeId)
                .orElseThrow(() -> new RuntimeException("NOT FOUND BY ID : " + storeId));

        if(savedStore.getMemberId() == memberRequest.getMemberId()) {

            Item item = new Item();
            item.setName(request.getName());
            item.setImage(request.getImage());
            item.setPrice(request.getPrice());
            item.setSummary(request.getSummary());
            item.setDescription(request.getDescription());
            item.setStore(savedStore);

            itemRepository.save(item);
        }
        else{
            // 에러처리
            throw new RuntimeException("memberId is not matched with storeId");
        }

    }
}
