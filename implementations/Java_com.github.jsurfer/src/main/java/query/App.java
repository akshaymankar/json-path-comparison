package query;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Collection;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jsfr.json.JsonSurferJackson;
import org.jsfr.json.JsonSurfer;

public class App {
    public static void main(String[] args) throws IOException, UnsupportedEncodingException {
        BufferedReader streamReader = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
        StringBuilder responseStrBuilder = new StringBuilder();

        String inputStr;
        while ((inputStr = streamReader.readLine()) != null)
            responseStrBuilder.append(inputStr);

        String json = responseStrBuilder.toString();

        JsonSurfer surfer = JsonSurferJackson.INSTANCE;
        Collection<Object> results = surfer.collectAll(json, args[0]);

        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(System.out, results);
    }
}
