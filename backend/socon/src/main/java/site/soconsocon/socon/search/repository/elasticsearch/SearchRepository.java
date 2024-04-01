package site.soconsocon.socon.search.repository.elasticsearch;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.data.geo.Distance;
import org.springframework.data.geo.Point;
import site.soconsocon.socon.search.domain.document.StoreDocument;

import java.util.Optional;

public interface SearchRepository extends ElasticsearchRepository<StoreDocument, Integer> {
    /**
     * 단위가 명시되지 않은 경우 기본적으로 킬로미터를 단위로 사용(Distance)
     * @param point
     * @param distance
     * @return
     */
    Optional<Page<StoreDocument>> findStoreDocumentsByLocationNear(Point point, Distance distance);
}
