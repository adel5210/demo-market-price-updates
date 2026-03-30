package dev.adel.market_price_updates;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@Slf4j
@SpringBootApplication
public class MarketPriceUpdatesApplication {

	public static void main(String[] args) {
		log.info("Starting MarketPriceUpdatesApplication...");
		SpringApplication.run(MarketPriceUpdatesApplication.class, args);		log.info("MarketPriceUpdatesApplication started successfully.");
	}

}