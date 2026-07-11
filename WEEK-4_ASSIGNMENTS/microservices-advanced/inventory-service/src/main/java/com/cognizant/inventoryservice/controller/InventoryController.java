package com.cognizant.inventoryservice.controller;

import com.cognizant.inventoryservice.model.Inventory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/inventory")
public class InventoryController {

    private final Map<Long, Inventory> inventoryMap = new HashMap<>();

    public InventoryController() {
        inventoryMap.put(1L, new Inventory(1L, 100));
        inventoryMap.put(2L, new Inventory(2L, 50));
        inventoryMap.put(3L, new Inventory(3L, 200));
    }

    @GetMapping("/{productId}")
    public Inventory getInventory(@PathVariable Long productId) {
        return inventoryMap.getOrDefault(productId, new Inventory(productId, 0));
    }
}
