package com.marshmellow.controller;

import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.marshmellow.service.BoardService;
import com.marshmellow.example.VO.BoardVO;
import com.marshmellow.example.VO.PageMaker;
import com.marshmellow.example.VO.SearchCriteria;

@Controller
@RequestMapping("/dashboard/*")
public class DashBoardController {
	private static final Logger logger = LoggerFactory.getLogger(DashBoardController.class);

	@Inject
	private BoardService service;

	@RequestMapping(value = "/index1", method = RequestMethod.GET)
	public String showHomePage1(Map<String, Object> model) {
	    return "/dashboard/index1";   
	}

	@RequestMapping(value = "/index2", method = RequestMethod.GET)
	public String showHomePage2(Map<String, Object> model) {
	    return "/dashboard/index2";   
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		logger.info(cri.toString());

		//model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(service.listCountCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model)
			throws Exception {
		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		service.remove(bno);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/sboard/list";
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modify(@RequestParam("bno") int bno, Model model, @ModelAttribute("cri") SearchCriteria cri)
			throws Exception {
		model.addAttribute(service.read(bno));
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPOST(BoardVO board, RedirectAttributes rttr, SearchCriteria cri) throws Exception {
		logger.info(cri.toString());
		
		service.modify(board);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		logger.info(rttr.toString());
		return "redirect:/sboard/list";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET() throws Exception {
		logger.info("register get.....");
	}
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(BoardVO board, RedirectAttributes rttr) throws Exception {
		logger.info("register post...");
		logger.info(board.toString());
		service.regist(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/sboard/list";
	}

}
