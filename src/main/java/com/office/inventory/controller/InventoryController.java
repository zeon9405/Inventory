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

		List<ItemVO> itemList = inventoryService.getItemListForUser();
		model.addAttribute("itemList", itemList);

		return "inventory/list";
	}

	@GetMapping("/rentItem")
	public String rentItem(HttpSession session, ItemVO itemVO) {
		
		String loginId = (String) session.getAttribute("user");
		
		EmpVO empVO = new EmpVO();
		empVO.setEmp_id(loginId);
		
		itemVO.setEmpVO(empVO);
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
        
        // 서비스에게 반납 처리 시키기
        inventoryService.returnProcess(rental_id, item_id);
        
        // 처리가 끝나면 다시 내 대여 목록 화면으로 보냄
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
	    
	    // POST에서도 반드시 검사해야 합니다!
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
	    
	    //해당 id의 상세정보를 가져옴
	    ItemVO item = inventoryService.getItemDetail(item_id);
	    
	    //가져온 데이터를 "item"이라는 이름으로 JSP에 넘겨줌
	    model.addAttribute("item", item);
	    
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
	/*
	 * // 비품 목록 보기: http://localhost:8080/inventory/list
	 * 
	 * @GetMapping("/list") public String list(Model model) { // 1. Service를 통해 DB
	 * 데이터를 가져옴 List<ItemVO> itemList = inventoryService.getItemList();
	 * 
	 * // 2. "itemList"라는 이름으로 데이터를 바구니(Model)에 담음 -> JSP에서 꺼내 쓸 이름
	 * model.addAttribute("itemList", itemList);
	 * 
	 * // 3. /WEB-INF/views/inventory/list.jsp 화면을 보여줘! return "inventory/list"; }
	 * 
	 * @GetMapping("/rent") public String rent(@RequestParam("item_id") int item_id)
	 * { // 1. Service를 통해 대여 로직 수행 (수량 감소 + 대여 기록 추가) boolean result =
	 * inventoryService.rentItem(item_id);
	 * 
	 * if(result) { System.out.println(item_id + "번 비품 대여 성공"); } else {
	 * System.out.println(item_id + "번 비품 대여 실패 (재고 부족 등)"); }
	 * 
	 * // 2. 대여 처리 후 다시 목록 화면으로 이동 (Redirect) return "redirect:list"; }
	 * 
	 * @GetMapping("/myRental") public String myRental(Model model) { String loginId
	 * = "user01"; // 아직 로그인을 안 만들었으니 임시 아이디 사용 List<RentalVO> myRentals =
	 * inventoryService.getMyRentalList(loginId); model.addAttribute("myRentals",
	 * myRentals); return "inventory/myRental"; }
	 * 
	 * @GetMapping("/return") public String returnItem(@RequestParam("rental_id")
	 * int rental_id,
	 * 
	 * @RequestParam("item_id") int item_id) {
	 * 
	 * inventoryService.returnItem(rental_id, item_id);
	 * 
	 * // 반납 완료 후 다시 '나의 대여 현황' 페이지로 리다이렉트 return "redirect:myRental"; }
	 */
}