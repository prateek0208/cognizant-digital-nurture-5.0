package com.cognizant.loanservice.model;

public class Loan {

    private Long id;
    private String type;
    private Double amount;

    public Loan() {
    }

    public Loan(Long id, String type, Double amount) {
        this.id = id;
        this.type = type;
        this.amount = amount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
}
