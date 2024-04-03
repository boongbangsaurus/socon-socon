package site.soconsocon.socon.search.domain.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import site.soconsocon.socon.search.domain.dto.common.SearchType;

/**
 * 	"content": "오소유",
 * 	"lat": 37.1820489,
 * 	"lng": 131.7718627,
 * 	"searchType": "name", //상호명 : name, 카테고리 : category,  도로명 주소 : address
 * 	"sort": "distance" //최단거리 : distance, 가나다 : name,
 * 	"isFavoriteSearch": true,
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SearchRequest {
    private String content;
    private String lat;
    private String lng;
    private SearchType searchType;
    private String sort;
    private Boolean isFavoriteSearch;
    private Integer page;
    private Integer size;
}
