package com.office.inventory.service;

import java.util.List;

import com.office.inventory.vo.CategoryVO;
import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

public interface InventoryService {
	
	public List<ItemVO> getItemListForUser();
	
	public List<ItemVO> getItemListForAdmin();
	
	public void insertRental(ItemVO itemVO);
	
	public void updateItemCnt(ItemVO itemVO);
	
	public int loginCheck(EmpVO empVO);

	public List<RentalVO> getMyRentalList(String emp_id);
	
	public void returnProcess(int rental_id, int item_id);
	
	public void insertNewItem(ItemVO itemVO);

	public ItemVO getItemDetail(int item_id);

	public void modifyItemConfirm(ItemVO itemVO);

	public void deleteItem(int item_id);

	public void terminateRentalOnly(int rental_id);

	public List<CategoryVO> getAllCategories();

	public List<RentalVO> getAllRentalList();
	
	
}