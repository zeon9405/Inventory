package com.office.inventory.service;

import java.util.List;

import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

public interface InventoryService {
	
	public List<ItemVO> getItemList();
	
	public void insertRental(ItemVO itemVO);
	
	public void updateItemCnt(ItemVO itemVO);
	
	public int loginCheck(EmpVO empVO);

	public List<RentalVO> getMyRentalList(String emp_id);
	
	public void returnProcess(int rental_id, int item_id);
	
	public void insertNewItem(ItemVO itemVO);
	
	
	/*
    // 전체 물품 목록 가져오기
    public List<ItemVO> getItemList();
    
    public List<RentalVO> getMyRentalList(String emp_id);
    
    public boolean rentItem(int item_id);
    
    public boolean returnItem(int rental_id, int item_id);
    */
}