package com.office.inventory.vo;

public class ItemVO {
	private int item_id; // 물품 번호
	private String item_name; // 물품명
	private int cat_id; // 카테고리 번호 (FK)
	private int item_price; // 가격
	private String status; // 상태 (AVAILABLE 등)
	private int quantity; // 수량 
	private String reg_date; // 등록일
	
	// 조인(Join) 결과를 담기 위해 카테고리 객체를 통째로 넣음
	private CategoryVO categoryVO;

	public ItemVO() {
	}

	// Getter & Setter
	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getCat_id() {
		return cat_id;
	}

	public void setCat_id(int cat_id) {
		this.cat_id = cat_id;
	}

	public int getItem_price() {
		return item_price;
	}

	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getReg_date() {
	    return reg_date;
	}

	public void setReg_date(String reg_date) {
	    this.reg_date = reg_date;
	}

	// categoryVO에 대한 Getter/Setter
	public CategoryVO getCategoryVO() {
		return categoryVO;
	}

	public void setCategoryVO(CategoryVO categoryVO) {
		this.categoryVO = categoryVO;
	}
}