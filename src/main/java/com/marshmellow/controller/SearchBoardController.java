package com.marshmellow.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.marshmellow.service.BoardService;
import com.marshmellow.util.MediaUtils;
import com.marshmellow.util.UploadFileUtils;
import com.marshmellow.example.VO.BoardVO;
//import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.PageMaker;
import com.marshmellow.example.VO.SearchCriteria;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	@Inject
	private BoardService service;

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
	public void read(@RequestParam("bNo") int bNo, @ModelAttribute("cri") SearchCriteria cri, Model model)
			throws Exception {
		model.addAttribute(service.read(bNo));
	}

	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
	public String remove(@RequestParam("bNo") int bNo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		service.remove(bNo);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");

		return "redirect:/sboard/list";
	}

	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modify(@RequestParam("bNo") int bNo, Model model, @ModelAttribute("cri") SearchCriteria cri)
			throws Exception {
		model.addAttribute(service.read(bNo));
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
	
	@RequestMapping("/getAttach/{bNo}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bNo") Integer bNo) throws Exception{
		return service.getAttach(bNo);
	}
	
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.GET)
	public void uploadAjax() {

	}

	@ResponseBody
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		logger.info("originalName : " + file.getOriginalFilename());
		//return new ResponseEntity<String>(file.getOriginalFilename(),HttpStatus.CREATED);
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}

	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		logger.info("FILE NAME: " + fileName);

		try {

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			MediaType mType = MediaUtils.getMediaType(formatName);

			HttpHeaders headers = new HttpHeaders();

			in = new FileInputStream(uploadPath + fileName);

			if (mType != null) {
				headers.setContentType(mType);
			} else {

				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) throws Exception {
		logger.info("delete file : " + fileName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if (mType != null) {
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
