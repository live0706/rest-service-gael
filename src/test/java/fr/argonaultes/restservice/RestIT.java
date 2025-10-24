package fr.argonaultes.restservice;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.fail;

public class RestIT {

    @Test
    void testIfDbExists() {
        if (System.getenv("DATABASE_URL_TEST").isBlank()) {
            fail("Missing env variable DATABASE_URL_TEST");
        }

    }
}