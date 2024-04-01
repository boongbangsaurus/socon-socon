package site.soconsocon.socon.search.domain.document;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.elasticsearch.annotations.*;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessHour;
import site.soconsocon.socon.store.domain.entity.jpa.BusinessRegistration;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Document(indexName = "stores")
@Setting(replicas = 0)
public class StoreDocument {
    @Id
    private Integer id;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String name;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String category; // 가게 분류

    @Field(type = FieldType.Text, index = false)
    private String image; // 가게 대표 이미지

    @Field(type = FieldType.Text, index = false)
    private String address; // 가게 주소

    @GeoPointField
    private GeoPointField location;

    @Field(type = FieldType.Text, analyzer = "nori")
    private String introduction; // 가게 설명

}
