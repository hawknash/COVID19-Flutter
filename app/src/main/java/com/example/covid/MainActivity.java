package com.example.covid;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import com.example.covid.parameter.Articles;
import com.example.covid.parameter.Headlines;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainActivity extends AppCompatActivity {

    public static TextView one;
    RecyclerView recyclerView;
    Adapter adapter;
    final String API_KEY = "c36f881ca1de4228860e4893bc948b45";
    Button refresh;
    List<Articles> articles = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        recyclerView = (RecyclerView) findViewById(R.id.recycler);
        refresh = findViewById(R.id.refresh);
     //   RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(MainActivity.this, LinearLayoutManager.VERTICAL, false);
      //  recyclerView.setLayoutManager(layoutManager);

        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);


        final String country = getCountry();
        fetchJson(country, API_KEY);


    }
    private void fetchJson(String country, String api_key) {
        Call<Headlines> call= Client.getInstance().getApi().getHeadlines(country,API_KEY);
        call.enqueue(new Callback<Headlines>() {
            @Override
            public void onResponse(Call<Headlines> call, Response<Headlines> response) {
                if (response.isSuccessful() && response.body().getArticles()!=null){
                    articles.clear();
                    articles=response.body().getArticles();
                    Log.e("yes","yes"+articles);
                    adapter =new Adapter(MainActivity.this,articles);
                    recyclerView.setAdapter(adapter);
                    Log.e("yes","yes"+adapter);
                }
                else{
                    Log.e("doooo","doooo");
                }
            }

            @Override
            public void onFailure(Call<Headlines> call, Throwable t) {
                Log.e("doooo","doooo"+t);


            }
        });
    }

    private String getCountry() {
        Locale locale=Locale.getDefault();
        String country=locale.getCountry();
        return country.toLowerCase();
    }
}
