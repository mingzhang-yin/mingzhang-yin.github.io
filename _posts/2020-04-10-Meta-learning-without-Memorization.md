---
title: "Meta-Learning without Memorization"
layout: post
date: 2020-04-10
tags: blog
comments: false
use_math: true
---

>  Paper:  https://openreview.net/pdf?id=BklEFpEYwS  

Let's consider how human-beings can obtain intelligence from school. In the morning, we go to school to take classes, answering the questions that teachers ask. In the evening, we come back home, finish the homework and check the answer key. In the end, when we graduate from school, we not only obtain some specific knowledge, but have learnt how to learn.  Meta-learning is a paradigm in artificial intelligence that mimics such learning procedure. By leveraging past experience from previous tasks, it aims to adapt fast to a few training data when it comes to a new task. tldr: we identify a common pitfall that prevents the fast adaptation for a variety of meta-learning algorithms and propose a method to prevent this pitfall.

## Basics
To set things up, we assume there are multiple tasks generated from a task distribution $p(\mathcal{T})$. Each task has some labeled training data $\mathcal{D} = (X,Y)$ and test data $\mathcal{D}^{\star} = (X^{\star},Y^{\star})$.  $\mathcal{M}$ represents all the meta-training data and $\mathcal{T}\_j$ is a new task. The meta-learner is trained on $\mathcal{M}$, adapted on the new task training data $\mathcal{D}_{j},$ and aims to make good predictions on the new task test inputs $X^{\star}\_{j}$. This process can be summarized in a hierarchical graphical model:
<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/graph3.png" alt="drawing" width="320"/>
</center>

## Memorization Problem
Let's come back to the student example at the beginning. The daily study at school can be considered as a task in meta-training, and we assume the student learn to solve one type of math problem each day. After a period, assume all types of required problems have been repeated several times in class. If a student can remember all types of problems, he/she does not need to attend the class and can answer the homework questions perfectly. Such memorization approach can solve new problems of the known types, but cannot solve an unseen type of problems. 

Let's consider another illustrative example.  Assume each task is a 1D regression on some related data. In the following figures, a meta-learning algorithm is trained to adapt on a few training data, as the red points, and to fit on the validation data, as the blue points, where the dashed line represents a good adapted model 

<p align="center">
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l1.jpg" width="50"/>  <img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l2.jpg" width="50"/>  <img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l3.jpg" width="50"/> 
</p>

:-:|:-:|:-:
![](https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l1.jpg)   |   ![](https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l2.jpg)| ![](https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l3.jpg) 

By training on multiple correlated tasks, the model develops a fast adaptation ability, which can generalize to solving tasks that are unseen in the meta-training, as the left figure below. However, we find if the meta-learner is flexible enough, a single model can solve all the training tasks without adapting to the task training data, as the right figure below. This solution may seem somewhat innocuous at the first glance. However, in the test-time, when facing a new task, the algorithm will not know how to utilize the task training data and therefore cannot solve the new task.

<p align="center">
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l4.jpg" width="50"/> <img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/l6.jpg" width="50"/> 
</p>

We call this phenomenon as the (complete) memorization problem in meta-learning and formally define it as
$$I(\hat{y}^{\star};\mathcal{D} | x^{\star}, \mathcal{M})=0$$
which means the predicted label and task training data are conditionally independent.


Notice the memorization problem is closely related to the task distribution. We find that if the meta-training tasks are mutually exclusive, which means a single model cannot solve all the tasks, the memorization problem will not occur. For example, in few-shot classification problems, mutually exclusive tasks are created by randomly shuffling the labels across tasks. However, in a wide range of problems the tasks are non-mutually exclusive. Therefore, the memorization problem widely exist and can influence many meta-learning algorithms.


## Meta-Regularization
Based on the above analysis and graphical model, we find that the information that is used to predict the task test labels comes from meta-traing data $\mathcal{M}$, task training data $\mathcal{D}$ and task test input $x^\star$. Hence, if we can control the information that flows from $\mathcal{M}$ and $x^\star$, and ask for accurate prediction in the meantime, we can encourage the model to use the information in $\mathcal{D}$ and not ignore it. Using the inequalities in information theory and PAC-Bayes theory, one approach to the meta-regularization we derived is based on the information bottleneck which regularizes
$$
D_{KL}(q(z^\star | x^\star, \theta)||r(z^\star ))
$$

The other approach is to regularize
$$
D_{KL}(q(\theta | \mathcal{M})||r(\theta))
$$
where $\theta$ are the parameters of an encoder: $x \to z$. Combining the meta-regularization with the objectives in Model Agnostic Meta-Learning(MAML) and Conditional Neural Process(CNP), we name our proposed new algorithms as MR-MAML and MR-CNP. We apply them to several datasets where the tasks are non-mutually exclusive, where the standard meta-learning algorithms can fail. The algorithms are tested on a pose prediction dataset where the goal is to predict the orientations of 3D objects by looking at their 2D images. Our methods outperform the compared methods by a large margin

<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/ee2.png" alt="drawing" width="600"/>
</center>

We also test on the non-mutually exclusive few-shot classification problems, for which standard meta-learning methods can give near random predictions in some cases
<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/ee3.png" alt="drawing" width="600"/>
</center>

## Takeaways
* Memorization is a prevalent problem for many meta-learning tasks and algorithms  
* Memorization problem is a task-level overfitting problem; it differs from standard datapoint-level problem
*  We can effectively control the memorization problem by meta-regularization, expanding the meta-learning to the domains that it cannot be effectively applied to before

Thanks to the collaborations of George Tucker，Mingyuan Zhou，Sergey Levine and Chelsea Finn!













