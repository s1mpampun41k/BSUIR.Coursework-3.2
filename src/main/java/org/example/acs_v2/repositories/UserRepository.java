package org.example.acs_v2.repositories;

import org.example.acs_v2.models.User;
import org.example.acs_v2.models.enums.LocationStudy;
import org.example.acs_v2.models.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Найти пользователя по логину
    User findByLogin(String login);

    @Query("SELECT DISTINCT u FROM User u JOIN u.tags t " +
            "WHERE u.role = 'TUTOR' " +
            "AND (:query IS NULL OR LOWER(SUBSTRING(t, 1, 5)) = LOWER(:query)) " +
            "AND (:minPrice IS NULL OR u.price >= :minPrice) " +
            "AND (:maxPrice IS NULL OR u.price <= :maxPrice) " +
            "AND (:city IS NULL OR u.city = :city) " +
            "AND (:educationSector IS NULL OR u.educationSector = :educationSector) " +
            "AND (:locationStudy IS NULL OR u.locationStudy = :locationStudy) " +
            "AND u.active = true AND u.verificationStatus = 'VERIFIED'")
    List<User> findTutorsByTagsPrefixWithFilters(
            @Param("query") String query,
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("city") String city,
            @Param("educationSector") String educationSector,
            @Param("locationStudy") LocationStudy locationStudy
    );

}

