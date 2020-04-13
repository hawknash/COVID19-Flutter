package com.example.covid;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.covid.parameter.Articles;
import com.example.covid.parameter.Headlines;
import com.squareup.picasso.Picasso;

import java.util.List;
import java.util.Locale;

import retrofit2.Callback;

public class Adapter extends RecyclerView.Adapter<Adapter.ViewHolder> {
    Context context;
    List<Articles> articles;
    Adapter(Context context, List<Articles> articles){
        this.context=  context;
        this.articles=articles;
    }
    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.list_item,parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        final Articles art=articles.get(position);
        String url=art.getUrl();
        holder.newsTitle.setText(art.getTitle());
        holder.newsDate.setText(art.getPublishedAt());
        String imageUrl=art.getUrlToImage();

        Picasso.get().load(imageUrl).into(holder.imageView);

        holder.cardView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(context, NewsInDetail.class);
                intent.putExtra("url",art.getUrl());
                context.startActivity(intent);
            }
        });
    }

    @Override
    public int getItemCount() {

        return articles.size();
    }

    public class ViewHolder extends  RecyclerView.ViewHolder {
        TextView newsTitle,newsDate;
        ImageView imageView;
        CardView cardView;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            newsDate=itemView.findViewById(R.id.newsDate);
            newsTitle=itemView.findViewById(R.id.newsTitle);
            imageView=itemView.findViewById(R.id.image);
            cardView=itemView.findViewById(R.id.cardView);
        }
    }
    public String getCountry()
    {
        Locale locale=Locale.getDefault();

        String country = locale.getCountry();
        return country.toLowerCase();
    }
}
