close all
%Precision: TP/TP+FP
%TP:class predicted as Positive which is True 
%FP: class predicted Positive which is False. (false alarm).
%Recall:TP/TP+FN
%FN: class predicted Negative which is False (forgotten TP).
N= 590; %DataSet - query
candidateimgname= zeros(NQueries, N);
candidateimgname= string(candidateimgname);
n_candidate_class= zeros(NQueries, N);
n_candidate_class= string(n_candidate_class);
queryimgname= zeros(NQueries, 1);
queryimgname= string(queryimgname);
query_class= zeros(NQueries, 1);
query_class= string(query_class);
imgout_allranks = zeros(NQueries,N);
n_positive=30;
RTP = zeros(1, N);
i = 1;
%Extract candidates' and queries index
for q = 1:2:n 
    dst_all=sortrows(dst,q);  % sort the results
    q_index(i)= dst_all(1,q+1);
    n_candidate_index(i, :) = dst_all(2:end,q+1).';
    i = i +1;
end
for j = 1:NQueries
    for i = 1:N
      imgid = n_candidate_index(j,i);
      candidateimgname(j, i)= allfiles(imgid).name;
      n_candidate_class(j, i)= str2double(strtok(candidateimgname(j, i), "_"));
    end
%Extract query's class
queryimgname(j, 1)= allfiles(q_index(1, j)).name;
query_class(j, 1)= str2double(strtok(queryimgname(j), "_"));
%-------------------------------------------------------------------------%
%Precision: TP/TP+FP or "How many of the predicted Positive are TP"
%Prediction result per image
    for i = 1:N
    imgout(j,i) = n_candidate_class(j, i) == query_class(j,1);
    end
%Compute Precesion
    for i = 1:N
        imgout_allranks(j, i)=sum(imgout(j, 1:i));
    end
NPrecisions(j, :)= imgout_allranks(j,:)./[1:N];
%-------------------------------------------------------------------------%
%Recall: TP/TP+FN or "How many of the Positives have been labelled Positive"
    for i = 1:N
        RTP(j, i) = sum(n_candidate_class(j, 1:i) == query_class(j,1));
    end
NRecall(j, :) = RTP(j, :)./n_positive;

MeanR = mean(NRecall);
MeanP = mean(NPrecisions);
%-------------------------------------------------------------------------%
%Plotting Curve
%N=[1,M] to have curve from 0 to 1.
hold on
plot(NRecall(j, :), NPrecisions(j, :));
end
plot(MeanR, MeanP, 'r-.');
hold on
plot([0,1],[0,1], 'k:')
hold off
title('ROC curve, quantization=5')
xlabel('Recall')
ylabel('Precision')
legend('Class: Planes', 'Class: Bikes', 'Class: Cars', 'Class: Trees', 'Mean Classes', 'Random Classifier')
hold off
%-------------------------------------------------------------------------%
%mAP: mean Average Precision

AP = sum(NPrecisions.*imgout, 2)/n_positive;
mAP = mean(AP, 1);
% %-------------------------------------------------------------------------%
% %GCH Quantization AP: Average Precision
% quant_AP(1, :) = [0.135685208543972 0.0931366759302238 0.223218399577603 0.207154252620186];
% quant_AP(2, :) = [0.0638252473218785 0.135974787821904 0.197151805460189 0.233640610575639];
% quant_AP(3, :) = [0.0633204629039412 0.174783224739309 0.230990213516209 0.0723748696324244];
% quant_AP(4, :) = [0.0499809673536661 0.259487739309969 0.311833503508838 0.0900327872739037];
% quant_AP(5, :) = [0.112425722074602 0.216145969040678 0.356513653972722 0.185141491165055];
% quant_mAP = mean(quant_AP, 2)';
% figure()
% quantization= [2:6]';
% hold on
% plot(quantization, quant_AP);
% plot(quantization, quant_mAP, 'r-.');
% xlabel('quantization')
% ylabel('AP')
% title("Quantization and AP")
% legend('Class: Planes', 'Class: Bikes', 'Class: Cars', 'Class: Trees', 'Mean AP')
% hold off

%-------------------------------------------------------------------------%
%Spatial Grid AP: Average Precision
% grid_AP(1, :) = [0.118742267105588;0.118405646531336;0.118907997442442;0.116170761652317];
% grid_AP(2, :) = [0.464587993560740;0.0668126845962366;0.141341954122844;0.197293575786717];
% grid_AP(3, :) = [0.551884632827439;0.118884244043922;0.0990946456238007;0.152663730945803];
% grid_AP(4, :) = [0.574714291629305;0.157351094282800;0.114130038755482;0.170823105095204];
% grid_AP(5, :) = [0.638869517768125;0.161262207558631;0.161312943798568;0.175681861877809];
% grid_AP(6, :) = [0.626607963785200;0.159349427009206;0.128961143974413;0.168852089210488];
% grid_AP(7, :) = [0.640393341930119;0.154251504170690;0.100332650200182;0.160197209610677];
% grid_AP(8, :) = [0.624438608112609;0.125212759974404;0.0919800074532480;0.149799182134697];
% grid_AP(9, :) = [0.625706677888804;0.168518165797079;0.0959246092390580;0.155227180752596];
% grid_AP(10, :) = [0.629346945704629;0.127100696905419;0.109674067435735;0.162682958139653];
% grid_mAP = mean(grid_AP, 2);
% n=1;
% m=1;
% for i=1:10
% cells(i,1)= (n+i)*(m+i)*3;
% end
% figure()
% hold on
% plot(cells, grid_AP);
% plot(cells, grid_mAP, 'r-.');
% xline(108,'g--');
% xlabel('Number of Cells')
% ylabel('AP')
% title("Gridding and Average Precision")
% legend('Class: Planes', 'Class: Bikes', 'Class: Cars', 'Class: Trees', 'Mean AP', 'Elbow')
% hold off