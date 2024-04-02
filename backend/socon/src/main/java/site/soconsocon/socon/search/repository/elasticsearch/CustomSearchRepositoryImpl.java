package site.soconsocon.socon.search.repository.elasticsearch;

import lombok.RequiredArgsConstructor;
import org.elasticsearch.index.query.QueryBuilders;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.data.geo.Point;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;
import site.soconsocon.socon.search.domain.document.StoreDocument;

@RequiredArgsConstructor
public class CustomSearchRepositoryImpl implements CustomSearchRepository {
    @Override
    public Page<StoreDocument> findStoreDocumentsByLocationNear(Point point, Pageable pageable) {
        // GeoPoint 인스턴스를 생성합니다.
        GeoPoint geoPoint = new GeoPoint(point.getX(), point.getY());

        // 위치 기반 쿼리를 구성합니다.
        Query searchQuery = new NativeSearchQuery(
                .withFilter(QueryBuilders.geoDistanceQuery("location")
                        .point(geoPoint.getLat(), geoPoint.getLon())
                        .distance("3km"))
                .withPageable(pageable)
                .build();

        // queryForPage 메서드를 사용하여 쿼리를 실행하고 결과를 가져옵니다.
        return elasticsearchOperations.queryForPage(searchQuery, StoreDocument.class);
    }
    @Override
    public Page<StoreDocument> findStoreDocumentsByLocationNearAndContent(Point point,String type,String content, Pageable pageable) {
        // GeoPoint 인스턴스를 생성합니다.
        GeoPoint geoPoint = new GeoPoint(point.getX(), point.getY());

        // 위치 기반 쿼리를 구성합니다.
        NativeSearchQuery searchQuery = new NativeSearchQueryBuilder()
                .withFilter(QueryBuilders
                        .geoDistanceQuery("location")
                            .point(geoPoint.getLat(), geoPoint.getLon())
                            .distance("3km")
                )
                .withQuery(QueryBuilders.matchQuery(type, content))
                .withPageable(pageable)
                .build();

        // queryForPage 메서드를 사용하여 쿼리를 실행하고 결과를 가져옵니다.
        return elasticsearchOperations.queryForPage(searchQuery, StoreDocument.class);
    }
}
