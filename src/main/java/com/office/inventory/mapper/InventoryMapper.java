package com.office.inventory.mapper;

import java.util.List;

import com.office.inventory.vo.CategoryVO;
import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

public interface InventoryMapper {
	
	public List<ItemVO> getItemListForUser();
	
	public List<ItemVO> getItemListForAdmin();
	
	public void insertRental(ItemVO itemVO);
	
	public void updateItemCnt(ItemVO itemVO);
	
	public int loginCheck(EmpVO empVO);

	public List<RentalVO> getMyRentalList(String emp_id);
	
	//반납일 업데이트 실행
	public void updateReturnDate(int rental_id);
	
	//재고 증가 실행
	public void increaseQuantity(int item_id);
	
	//새로운 item 추가
	public void insertNewItem(ItemVO itemVO);
	
	public ItemVO getItemDetail(int item_id);

	public void updateItem(ItemVO itemVO);

	public void deleteItem(int item_id);

	public void terminateRentalOnly(int rental_id);

	public List<CategoryVO> getAllCategories();
	
	List<RentalVO> getAllRentalList();
	
	
	
	

}