package com.marshmellow.example.DAO;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO {

	@Inject
	private SqlSession sqlSession;

/*************************************************************/
	private static String namespace = "mappers.pointMapper";
/*************************************************************/

	@Override
	public void updatePoint(String uId, int point) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uId", uId);
		paramMap.put("point", point);

		sqlSession.update(namespace + ".updatePoint", paramMap);

	}

}
