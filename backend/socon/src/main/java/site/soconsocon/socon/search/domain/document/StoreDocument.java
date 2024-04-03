package site.soconsocon.socon.search.domain.document;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.elasticsearch.annotations.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.core.geo.GeoPoint;

@Getter
@Setter
@Document(indexName = "stores")
@Builder
public class StoreDocument {
    @Id
    private Integer id;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String name;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String category; // 가게 분류

    private String image; // 가게 대표 이미지

    @GeoPointField
    private GeoPoint location;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String address; // 가게 주소

    @Field(type = FieldType.Text, analyzer = "nori")
    private String introduction; // 가게 설명

}
