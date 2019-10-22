package com.marshmellow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.marshmellow.service.ReplyService;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.PageMaker;
import com.marshmellow.example.VO.ReplyVO;

@Controller
@RequestMapping("/replies")
public class ReplyController {

	@Inject
	private ReplyService service;

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO reply) {
		ResponseEntity<String> entity = null;
		try {
			service.addReply(reply);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/all/{bNo}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bNo") Integer bNo) {
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			entity = new ResponseEntity<List<ReplyVO>>(service.listReply(bNo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/{rNo}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("rNo") Integer rNo, @RequestBody ReplyVO reply) {
		ResponseEntity<String> entity = null;
		try {
			reply.setrNo(rNo);
			service.modifyReply(reply);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	@RequestMapping(value = "/{rNo}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rNo") Integer rNo) {
		ResponseEntity<String> entity = null;
		try {
			service.removeReply(rNo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/{bNo}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bNo") Integer bNo,@PathVariable("page") Integer page) {
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String,Object> map = new HashMap<String,Object>();
			List<ReplyVO> list = service.listReplyPage(bNo, cri);
			map.put("list", list);
			
			int replyCount = service.count(bNo);
			pageMaker.setTotalCount(replyCount);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
}
