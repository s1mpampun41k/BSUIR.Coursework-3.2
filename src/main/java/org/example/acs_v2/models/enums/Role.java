package org.example.acs_v2.models.enums;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_ADMIN, ROLE_MAIN_ADMIN;

    @Override
    public String getAuthority() {
        return name();
    }
}
