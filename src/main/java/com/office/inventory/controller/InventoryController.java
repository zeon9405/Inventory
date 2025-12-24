package com.office.inventory.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.office.inventory.service.InventoryService;
import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

@Controller // 이 클래스는 웹 요청을 처리하는 컨트롤러임
@RequestMapping("/")
public class InventoryController {

    @Autowired
    private InventoryService inventoryService;
    
    @GetMapping("/")
    public String main() {
    	return "inventory/main";
    }
    
    @GetMapping("/itemList")
    public String itemListPage(Model model) {
    	
    	List<ItemVO> itemList = inventoryService.getItemList();
    	model.addAttribute("itemList", itemList);
    	
    	
    	return "inventory/list";
    }
    
    @GetMapping("/rentItem")
    public String rentItem(ItemVO itemVO) {
    
    	// 1. rent 테이블에 데이터 insert
    	inventoryService.insertRental(itemVO);
    	
    	// 2. item 테이블에 갯수 -1
    	inventoryService.updateItemCnt(itemVO);
    	
    	
    	return "redirect:itemList";
    }
    
    @GetMapping("/loginPage")
    public String loginPage() {
    	return "inventory/login";
    }
    
    @GetMapping("/login")
    public String login(EmpVO empVO, HttpServletRequest request, Model model) {
    	// 로그인 정보 확인
    	
    	int loginCheck = inventoryService.loginCheck(empVO);
    	if(loginCheck == 0) { // 로그인 정보 없음
    		model.addAttribute("loginMsg","일치하는 회원 정보가 없습니다.");
    		
    		return "inventory/login";
    		
    	}else { // 로그인 정보 있음
    		// 세션설정
    		HttpSession session = request.getSession();
    		session.setAttribute("user",empVO.getEmp_id());
    		
    		return "redirect:/";
    	}
    	
    }
    
    @GetMapping("/logoutPage")
    public String logoutPage(HttpServletRequest request) {
    	
    	// 세션 삭제
		HttpSession session = request.getSession();
		session.invalidate();
    	
    	return "redirect:/";
    }
    
    
    
    

    
    
    
    
/*
 // 비품 목록 보기: http://localhost:8080/inventory/list
    @GetMapping("/list")
    public String list(Model model) {
        // 1. Service를 통해 DB 데이터를 가져옴
        List<ItemVO> itemList = inventoryService.getItemList();
        
        // 2. "itemList"라는 이름으로 데이터를 바구니(Model)에 담음 -> JSP에서 꺼내 쓸 이름
        model.addAttribute("itemList", itemList);
        
        // 3. /WEB-INF/views/inventory/list.jsp 화면을 보여줘!
        return "inventory/list";
    }
    
    @GetMapping("/rent")
    public String rent(@RequestParam("item_id") int item_id) {
        // 1. Service를 통해 대여 로직 수행 (수량 감소 + 대여 기록 추가)
        boolean result = inventoryService.rentItem(item_id);
        
        if(result) {
            System.out.println(item_id + "번 비품 대여 성공");
        } else {
            System.out.println(item_id + "번 비품 대여 실패 (재고 부족 등)");
        }

        // 2. 대여 처리 후 다시 목록 화면으로 이동 (Redirect)
        return "redirect:list";
    }
    
    @GetMapping("/myRental")
    public String myRental(Model model) {
        String loginId = "user01"; // 아직 로그인을 안 만들었으니 임시 아이디 사용
        List<RentalVO> myRentals = inventoryService.getMyRentalList(loginId);
        model.addAttribute("myRentals", myRentals);
        return "inventory/myRental";
    }
    
    @GetMapping("/return")
    public String returnItem(@RequestParam("rental_id") int rental_id, 
                             @RequestParam("item_id") int item_id) {
        
        inventoryService.returnItem(rental_id, item_id);
        
        // 반납 완료 후 다시 '나의 대여 현황' 페이지로 리다이렉트
        return "redirect:myRental"; 
    }
    */
}