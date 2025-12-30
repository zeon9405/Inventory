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
import com.office.inventory.vo.CategoryVO;
import com.office.inventory.vo.EmpVO;
import com.office.inventory.vo.ItemVO;
import com.office.inventory.vo.RentalVO;

@Controller
@RequestMapping("/")
public class InventoryController {

	@Autowired
	private InventoryService inventoryService;

	@GetMapping("/")
	public String main() {
		return "inventory/main";
	}

	@GetMapping("/itemList")
	public String itemListPage(Model model, HttpSession session) {

		String loginId = (String) session.getAttribute("user");
		
		List<ItemVO> itemList = inventoryService.getItemListForUser();
		model.addAttribute("itemList", itemList);
		
		if (loginId == null) {
			return "redirect:/loginPage";
		}

		return "inventory/list";
	}

	@GetMapping("/rentItem")
	public String rentItem(HttpSession session, ItemVO itemVO) {
		
		String loginId = (String) session.getAttribute("user");
		
		EmpVO empVO = new EmpVO();
		empVO.setEmp_id(loginId);
		
		itemVO.setEmpVO(empVO);
		// rent 테이블에 데이터 insert
		inventoryService.insertRental(itemVO);

		// item 테이블에 갯수 -1
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
		if (loginCheck == 0) { // 로그인 정보 없음
			model.addAttribute("loginMsg", "일치하는 회원 정보가 없습니다.");

			return "inventory/login";

		} else { // 로그인 정보 있음
			// 세션설정
			HttpSession session = request.getSession();
			session.setAttribute("user", empVO.getEmp_id());

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

	
	@GetMapping("/myRental")
	public String myRental(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("user");
		
		System.out.println("현재 로그인 한 아이디 : " + loginId);
		
		List<RentalVO> myRentals = inventoryService.getMyRentalList(loginId);
		model.addAttribute("myRentals", myRentals);
		if (loginId == null) {
			return "redirect:/loginPage";
		}
		return "inventory/myRental";
	}
	

	@GetMapping("/returnItem")
    public String returnItem(@RequestParam("rental_id") int rental_id,
                            @RequestParam("item_id") int item_id) {
        
        inventoryService.returnProcess(rental_id, item_id);
        
        return "redirect:/myRental";
    }
	
	@GetMapping("/returnDeletedItem")
	public String returnDeletedItem(@RequestParam("rental_id") int rental_id) {
	    // 재고를 건드리지 않고, 대여 테이블의 반납 완료일(ret_act_date)만 현재 시간으로 업데이트
	    inventoryService.terminateRentalOnly(rental_id);
	    
	    return "redirect:/myRental"; // 다시 내 대여 목록으로
	}
	
	@GetMapping("/admin/adminPage")
	public String adminPage(HttpSession session) {
		String loginId = (String) session.getAttribute("user");
	    
	    if (!"admin".equals(loginId)) {
	        return "redirect:/"; 
	    }
	    return "inventory/admin/adminPage"; 
	}
	
	@GetMapping("/admin/list")
	public String list(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("user");
		List<ItemVO> itemList = inventoryService.getItemListForAdmin();
		model.addAttribute("itemList", itemList);
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";
	    
	    return "inventory/admin/list";
	}
	
	@GetMapping("/admin/itemRegForm")
	public String itemRegForm(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("user");
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";
	    
	    List<CategoryVO> categoryList = inventoryService.getAllCategories();
	    
	    model.addAttribute("categoryList", categoryList);
	    
	    return "inventory/admin/itemRegForm";
	}

	@PostMapping("/admin/insertNewItem")
	public String insertNewItem(ItemVO itemVO, HttpSession session) {
		//보안검사. 세션에서 아이디 꺼내기
		String loginId = (String) session.getAttribute("user");
		
		//관리자가 아니면 X
		if (loginId == null ||	 !loginId.equals("admin")) {
	        return "redirect:/";
	    }
		
		//서비스 호출하여 DB에 저장
		inventoryService.insertNewItem(itemVO);
		
		//완료 후 물품 목록 페이지로 이동
	    return "redirect:/admin/list";
	}
	
	@GetMapping("/admin/editForm")	
	public String editForm(HttpSession session, @RequestParam("item_id") int item_id, Model model) {
		String loginId = (String) session.getAttribute("user");
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";
	    
	    ItemVO item = inventoryService.getItemDetail(item_id);
	   
	    model.addAttribute("item", item);
	    
	    List<CategoryVO> categoryList = inventoryService.getAllCategories(); 
	    model.addAttribute("categoryList", categoryList);
	    
		return "inventory/admin/editForm";
	}
	
	@PostMapping("admin/modifyItem")
	public String modifyItem(HttpSession session, ItemVO itemVO) {
		String loginId = (String) session.getAttribute("user");
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";
	    
	    inventoryService.modifyItemConfirm(itemVO);
	    
	    return "redirect:/admin/list";
		
	}
	
	@GetMapping("admin/deleteItem")
	public String deleteItem(HttpSession session, @RequestParam("item_id") int item_id) {
		String loginId = (String) session.getAttribute("user");
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";
		
	    inventoryService.deleteItem(item_id);
		
		return "redirect:/admin/list";
	}
	
	@GetMapping("admin/allRentalList")
	public String allRentalList(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("user");
	    if (!"admin".equals(loginId)) 
	    	return "redirect:/";

	    List<RentalVO> allRentals = inventoryService.getAllRentalList();
	    
	    model.addAttribute("allRentals", allRentals);
	    
	    model.addAttribute("today", new java.util.Date());
	    
		return "inventory/admin/allRentalList";
	}
}