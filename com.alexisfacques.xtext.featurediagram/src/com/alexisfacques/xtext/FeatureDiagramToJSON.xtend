package com.alexisfacques.xtext

import com.alexisfacques.xtext.featureDiagram.ExtendedFeature
import com.alexisfacques.xtext.featureDiagram.Feature
import com.alexisfacques.xtext.featureDiagram.FeatureDefinition
import com.alexisfacques.xtext.featureDiagram.FeatureGroup

import org.eclipse.emf.common.util.EList

import java.util.HashMap
import java.util.ArrayList

import com.google.common.collect.Maps
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

class FeatureDiagramToJSON {
	static def String toJSON(Feature feature) {	
		var Gson gson = new GsonBuilder().disableHtmlEscaping().create();
		return gson.toJson(map(feature));
	}

	static def ArrayList<HashMap<Object,Object>> list(EList<FeatureDefinition> definitions){
  		val res = new ArrayList<HashMap<Object,Object>>();
  		
  		definitions.forEach[definition |
  			if(definition instanceof FeatureGroup) {
				definition.children.forEach[child | {
					res.add(map(child));
				}];
			}

			else if (definition instanceof ExtendedFeature) {
				res.add(map(definition.feature));
			}
    		];
    		
    		return res;
  	}
  	
	static def HashMap<Object,Object> map(Feature feature) {
		val res = Maps::<Object,Object>newHashMap;
		
		res.put("name", feature.name);
		res.put("id",feature.id);
		res.put("children",list(feature.children));

		return res;
	}
}