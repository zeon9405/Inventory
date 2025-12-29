package com.office.inventory.vo;

import java.util.Date;

public class RentalVO {
    private int rental_id;
    private String emp_id;
    private int item_id;
    private Date rent_date;      // 대여일
    private Date ret_exp_date;   // 반납 예정일
    private Date ret_act_date;   // 실제 반납일 (NULL이면 미반납 상태)
    
    private String item_name; 
    private String status;
    private String emp_name;

    public int getRental_id() { return rental_id; }
    public void setRental_id(int rental_id) { this.rental_id = rental_id; }

    public String getEmp_id() { return emp_id; }
    public void setEmp_id(String emp_id) { this.emp_id = emp_id; }

    public int getItem_id() { return item_id; }
    public void setItem_id(int item_id) { this.item_id = item_id; }

    public Date getRent_date() { return rent_date; }
    public void setRent_date(Date rent_date) { this.rent_date = rent_date; }

    public Date getRet_exp_date() { return ret_exp_date; }
    public void setRet_exp_date(Date ret_exp_date) { this.ret_exp_date = ret_exp_date; }

    public Date getRet_act_date() { return ret_act_date; }
    public void setRet_act_date(Date ret_act_date) { this.ret_act_date = ret_act_date; }

    public String getItem_name() { return item_name; }
    public void setItem_name(String item_name) { this.item_name = item_name; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
    
    
}