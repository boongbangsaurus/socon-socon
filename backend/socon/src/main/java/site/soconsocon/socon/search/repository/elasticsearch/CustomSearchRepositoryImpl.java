package site.soconsocon.socon.search.repository.elasticsearch;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;
import org.springframework.data.elasticsearch.core.query.Criteria;
import org.springframework.data.elasticsearch.core.query.CriteriaQuery;
import org.springframework.data.geo.Point;
import org.springframework.stereotype.Repository;
import site.soconsocon.socon.search.domain.document.StoreDocument;

import java.util.List;
import java.util.stream.Collectors;

@Repository
public class CustomSearchRepositoryImpl implements CustomSearchRepository {

    private final ElasticsearchOperations elasticsearchOperations;

    public CustomSearchRepositoryImpl(ElasticsearchOperations elasticsearchOperations) {
        this.elasticsearchOperations = elasticsearchOperations;
    }

    @Override
    public Page<StoreDocument> findStoreDocumentsByLocationNear(Point point, Pageable pageable) {
        Criteria criteria = new Criteria("location").within(GeoPoint.fromPoint(point), "3km");
        CriteriaQuery query = new CriteriaQuery(criteria, pageable);

        SearchHits<StoreDocument> searchHits = elasticsearchOperations.search(query, StoreDocument.class);
        List<StoreDocument> storeDocuments = searchHits.getSearchHits().stream()
                .map(SearchHit::getContent)
                .collect(Collectors.toList());

        return new PageImpl<>(storeDocuments, pageable, searchHits.getTotalHits());
    }
    @Override
    public Page<StoreDocument> findStoreDocumentsByLocationNearAndContent(Point point, String type, String content, Pageable pageable) {
        Criteria criteria = new Criteria("location").within(GeoPoint.fromPoint(point), "3km")
                .and(new Criteria(type).is(content));

        CriteriaQuery query = new CriteriaQuery(criteria, pageable);

        SearchHits<StoreDocument> searchHits = elasticsearchOperations.search(query, StoreDocument.class);
        List<StoreDocument> storeDocuments = searchHits.getSearchHits().stream()
                .map(SearchHit::getContent)
                .collect(Collectors.toList());

        return new PageImpl<>(storeDocuments, pageable, searchHits.getTotalHits());
    }
}
