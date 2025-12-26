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

@Service // "스프링아, 이 클래스는 서비스 역할을 하는 부품이야!"라고 등록하는 것
public class InventoryServiceImpl implements InventoryService {

    @Autowired // "아까 만든 Mapper 엔진을 여기에 자동으로 연결해줘!"
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
        // 이미 만들어둔 updateReturnDate 매퍼를 재활용
        inventoryMapper.updateReturnDate(rental_id);
    }
  
 // ServiceImpl 내용
    @Override
    public List<CategoryVO> getAllCategories() {
        return inventoryMapper.getAllCategories();
    }
    
    @Override
    public List<RentalVO> getAllRentalList(){
    	return inventoryMapper.getAllRentalList();
    }
    
    /*

    @Override
    public List<ItemVO> getItemList() {
        // 실제 로직: Mapper를 호출해서 DB 데이터를 가져옴
        return inventoryMapper.getAllItems();
    }
    
    @Transactional // 중요: 수량 감소와 기록 추가가 동시에 성공해야 함
    public boolean rentItem(int item_id) {
        int updateCount = inventoryMapper.decreaseQuantity(item_id); // 수량 -1
        if(updateCount > 0) {
            inventoryMapper.insertRental(item_id); // 대여 기록 추가
            return true;
        }
        return false;
    }
    
    @Override
    public List<RentalVO> getMyRentalList(String emp_id) {
        return inventoryMapper.getMyRentalList(emp_id);
    }
    
    @Transactional // 둘 중 하나라도 실패하면 롤백! 중요합니다.
    @Override
    public boolean returnItem(int rental_id, int item_id) {
        // 1. 반납일 기록
        int res1 = inventoryMapper.updateReturnDate(rental_id);
        
        // 2. 재고 수량 복구
        int res2 = inventoryMapper.increaseQuantity(item_id);
        
        // 둘 다 성공(1)해야 true 반환
        return (res1 > 0 && res2 > 0);
    }
    */
}