package com.company.project.utilities;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FallbackController {

    @RequestMapping("/fallback/external")
    public ResponseEntity<String> externalFallback() {
        String fallbackResponse = "Fallback response for external service";
        return ResponseEntity.ok(fallbackResponse);
    }

    @RequestMapping("/fallback/shipping")
    public ResponseEntity<String> shippingFallback() {
        String fallbackResponse = "Fallback response for shipping service";
        return ResponseEntity.ok(fallbackResponse);
    }
}
