package com.office.inventory.vo;

public class CategoryVO {
    private int cat_id;      // 카테고리 번호
    private String cat_name;  // 카테고리 이름

    // 기본 생성자
    public CategoryVO() {}

    // Getter & Setter
    public int getCat_id() { return cat_id; }
    public void setCat_id(int cat_id) { this.cat_id = cat_id; }
    public String getCat_name() { return cat_name; }
    public void setCat_name(String cat_name) { this.cat_name = cat_name; }
}