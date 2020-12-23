package ru.vuan.graphql.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "BUILDING")
public class Building extends BaseEntityWithUuidPk {
    @Column(name = "ADDRESS", length = 700)
    private String address;

    @Column(name = "cadastr_number", length = 50)
    private String cadastrNumber;

    @Column(name = "erpo_number", unique = true)
    private int erpoNumber;

    @Column(name = "house_number", length = 50)
    private String houseNumber;

    @Column(name = "object_name")
    private String objectName;

    @Column(name = "developer_inn", length = 12)
    @NonNull
    private String developerInn;

    @Column(name = "sgs_number")
    private int sgsNumber;

    @NonNull
    @Column(name = "created_date")
    @Temporal(value = TemporalType.TIMESTAMP)
    private Date createdDate;
    @Column(name = "last_modified_date")
    @Temporal(value = TemporalType.TIMESTAMP)
    private Date lastModifiedDate;

    @Column(name = "developer_name")
    @NonNull
    private String developerName;

    @Column(name = "developer_short_name")
    private String developerShortName;

    @NonNull
    @Column(name = "developer_id")
    private int developerId;

    @Column(name = "region_code")
    private int regionCode;

    @Column(name = "status", length = 50)
    @NonNull
    private String status;

    @Column(name = "documents")
    @Type(type = "text")
    private String documents;

    @Column(name = "option", length = 100)
    private String option;
}
