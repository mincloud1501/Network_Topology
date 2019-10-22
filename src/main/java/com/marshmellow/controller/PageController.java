package com.marshmellow.controller;

import java.util.Map;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/pages/*")
public class PageController {
	//private static final Logger logger = LoggerFactory.getLogger(PageController.class);

	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String showPage1(Map<String, Object> model) {
	    return "/pages/calendar";   
	}

	@RequestMapping(value = "/tables/data", method = RequestMethod.GET)
	public String showPage2(Map<String, Object> model) {
	    return "/pages/tables/data";   
	}
	
	@RequestMapping(value = "/treeview", method = RequestMethod.GET)
	public String showPage3(Map<String, Object> model) {
	    return "/pages/treeview/large";   
	}
	
	@RequestMapping(value = "/gridview", method = RequestMethod.GET)
	public String showPage4(Map<String, Object> model) {
	    return "/pages/gridview/auigridTest";   
	}
	
	@RequestMapping(value = "/websocket", method = RequestMethod.GET)
	public String showPage5(Map<String, Object> model) {
	    return "/pages/websocket";   
	}

	@RequestMapping(value = "/chat")
	public String viewChattingPage() {
        return "/pages/chat";
    }

    @RequestMapping("/paint")
    public String viewPaintingPage() {
        return "/pages/paint";
    }

    @RequestMapping("/charts/topology")
    public String viewTopology() {
        return "/pages/charts/topology";
    }
    
    @RequestMapping("/charts/topology2")
    public String viewTopology2() {
        return "/pages/charts/topology2";
    }
    
    @RequestMapping("/charts/topology3")
    public String viewTopology3() {
        return "/pages/charts/topology3";
    }
    
    @RequestMapping("/charts/topology4")
    public String viewTopology4() {
        return "/pages/charts/topology4"; 
    }
    
    @RequestMapping("/charts/topology5")
    public String viewTopology5() {
        return "/pages/charts/topology5"; 
    }
    
    @RequestMapping("/charts/topology6")
    public String viewTopology6() {
        return "/pages/charts/topology6"; 
    }
}