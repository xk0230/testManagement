package com.codyy.oc.admin.filter;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;

public class TransferMap {

	private static final char REFERENCE_START = '&';
	private static final char REFERENCE_END = ';';

	private static final String PROPERTIES_FILE = "transfermap.properties";
	private final String[] characterToEntityReferenceMap = new String[3000];

	private static TransferMap instance = new TransferMap();

	public static TransferMap getInstance() {
		return instance;
	}

	private TransferMap() {
		Properties entityReferences = new Properties();

		// Load reference definition file
		InputStream is = TransferMap.class.getResourceAsStream(PROPERTIES_FILE);
		if (is == null) {
			throw new IllegalStateException("Cannot find reference definition file [" + PROPERTIES_FILE + "] as class path resource");
		}
		try {
			try {
				entityReferences.load(is);
			} finally {
				is.close();
			}
		} catch (IOException ex) {
			throw new IllegalStateException("Failed to parse reference definition file [" + PROPERTIES_FILE + "]: " + ex.getMessage());
		}

		// Parse reference definition properties
		for (Map.Entry<Object, Object> entry : entityReferences.entrySet()) {
			String key = entry.getKey().toString();
			int referredChar = Integer.parseInt(key);
			if (referredChar < 1000 || (referredChar >= 8000 && referredChar < 10000)) {
				int index = (referredChar < 1000 ? referredChar : referredChar - 7000);
				String reference = entry.getValue().toString();
				characterToEntityReferenceMap[index] = REFERENCE_START + reference + REFERENCE_END;
			}
		}
	}

	public String convertToReference(char character) {
		if (character < 1000 || (character >= 8000 && character < 10000)) {
			int index = (character < 1000 ? character : character - 7000);
			String entityReference = characterToEntityReferenceMap[index];
			if (entityReference != null) {
				return entityReference;
			}
		}
		return null;
	}

}
