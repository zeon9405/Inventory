package com.office.inventory.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.office.inventory.mapper.InventoryMapper;
import com.office.inventory.vo.CategoryVO;
import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

@Service 
public class InventoryServiceImpl implements InventoryService {

    @Autowired 
    private InventoryMapper inventoryMapper;
    
    @Override
    public List<ItemVO> getItemListForUser(){
    	return inventoryMapper.getItemListForUser();
    }
    
    @Override
    public List<ItemVO> getItemListForAdmin(){
    	return inventoryMapper.getItemListForAdmin();
    }
    
    @Override
    public void insertRental(ItemVO itemVO) {
    	inventoryMapper.insertRental(itemVO);
    }
    
    @Override
    public void updateItemCnt(ItemVO itemVO) {
    	inventoryMapper.updateItemCnt(itemVO);
    }
    
    @Override
    public int loginCheck(EmpVO empVO){
    	return inventoryMapper.loginCheck(empVO);
    }
    
    @Override
    public List<RentalVO> getMyRentalList(String emp_id){
    	return inventoryMapper.getMyRentalList(emp_id);
    }
    
    @Override
    @Transactional
    public void returnProcess(int rental_id, int item_id) {
    	inventoryMapper.increaseQuantity(item_id);
    	inventoryMapper.updateReturnDate(rental_id);
    }
    
    @Override
    public void insertNewItem(ItemVO itemVO) {
    	inventoryMapper.insertNewItem(itemVO);
    }
    
    @Override
    public ItemVO getItemDetail(int item_id) {
    	return inventoryMapper.getItemDetail(item_id);
    }
    
    @Override
    public void modifyItemConfirm(ItemVO itemVO) {
    	inventoryMapper.updateItem(itemVO);
    }
    
    @Override
    public void deleteItem(int item_id) {
    	inventoryMapper.deleteItem(item_id);
    }

    @Override
    public void terminateRentalOnly(int rental_id) {
        //updateReturnDate 매퍼를 재활용
        inventoryMapper.updateReturnDate(rental_id);
    }
  
    @Override
    public List<CategoryVO> getAllCategories() {
        return inventoryMapper.getAllCategories();
    }
    
    @Override
    public List<RentalVO> getAllRentalList(){
    	return inventoryMapper.getAllRentalList();
    }
    
}