package com.yjy.utils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Collections;

/**
 * 多叉树类
 */
public class MultipleTree {
	
	public String createTree(List<Map<String, String>> dataList) {
		
		Map<String, Object> nodeList = new HashMap<String, Object>();
		// 根节点
		Node root = new Node();
		root.id = "main";
		root.text = "默认根菜单";
		// 根据结果集构造节点列表（存入散列表）
		for (Iterator<Map<String, String>> it = dataList.iterator(); it.hasNext();) {
			Map<String, String> dataRecord = (Map<String, String>) it.next();
			Node node = new Node();
			node.id = (String) dataRecord.get("id");
			node.text = (String) dataRecord.get("text");
			node.parentId = (String) dataRecord.get("parentId");
			node.order = (String) dataRecord.get("order");
			nodeList.put(node.id, node);
		}
		// 构造无序的多叉树
		Set<Map.Entry<String, Object>> entrySet = nodeList.entrySet();
		for (Iterator<Map.Entry<String, Object>> it = entrySet.iterator(); it.hasNext();) {
			Node node = (Node) ((Map.Entry<String, Object>) it.next()).getValue();
			if (node.parentId == null || node.parentId.equals("")) {
				root.addChild(node);
			} else {
				((Node) nodeList.get(node.parentId)).addChild(node);
			}
		}
		// 输出无序的树形菜单的JSON字符串
		System.out.println(root.toString());
		// 对多叉树进行横向排序
		root.sortChildren();
		// 输出有序的树形菜单的JSON字符串
		System.out.println(root.toString());
		
		return root.toString();
	}
	
}

class Node {
	/**
	 * 节点编号
	 */
	public String id;
	/**
	 * 节点内容
	 */
	public String text;
	/**
	 * 节点内容
	 */
	public String order;
	/**
	 * 父节点编号
	 */
	public String parentId;
	/**
	 * 孩子节点列表
	 */
	private Children children = new Children();

	// 先序遍历，拼接JSON字符串
	public String toString() {
		String result = "{" + "id : '" + id + "'" + ", text : '" + text + "'";

		if (children != null && children.getSize() != 0) {
			result += ", children : " + children.toString();
		} else {
			result += ", leaf : true";
		}

		return result + "}";
	}

	// 兄弟节点横向排序
	public void sortChildren() {
		if (children != null && children.getSize() != 0) {
			children.sortChildren();
		}
	}

	// 添加孩子节点
	public void addChild(Node node) {
		this.children.addChild(node);
	}
}

/**
 * 孩子列表类
 */
class Children {
	
	private List<Object> list = new ArrayList<Object>();

	public int getSize() {
		return list.size();
	}

	public void addChild(Node node) {
		list.add(node);
	}

	// 拼接孩子节点的JSON字符串
	public String toString() {
		String result = "[";
		for (Iterator<Object> it = list.iterator(); it.hasNext();) {
			result += ((Node) it.next()).toString();
			result += ",";
		}
		result = result.substring(0, result.length() - 1);
		result += "]";
		return result;
	}

	// 孩子节点排序
	public void sortChildren() {
		// 对本层节点进行排序
		// 可根据不同的排序属性，传入不同的比较器，这里传入ID比较器
		Collections.sort(list, new NodeOrderComparator());
		// 对每个节点的下一层节点进行排序
		for (Iterator<Object> it = list.iterator(); it.hasNext();) {
			((Node) it.next()).sortChildren();
		}
	}
}

/**
 * 节点比较器
 */
class NodeOrderComparator implements Comparator<Object> {
	// 按照节点编号比较
	public int compare(Object o1, Object o2) {
		int j1 = Integer.parseInt(((Node) o1).order);
		int j2 = Integer.parseInt(((Node) o2).order);
		return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
	}
}