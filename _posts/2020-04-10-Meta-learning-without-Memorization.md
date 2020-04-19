---
title: "Meta-Learning without Memorization"
layout: post
date: 2020-04-10
tags: blog
comments: false
use_math: true
---

>  Paper link: [OpenReview.net](https://openreview.net/pdf?id=BklEFpEYwS)    
>  Code link: [Google Research Github](https://github.com/google-research/google-research/tree/master/meta_learning_without_memorization)

Consider how people learn at school. In the morning, we go to school, taking classes and answering questions asked by teachers. In the evening, we go back home, finishing homeworks and checking answer key. This daily routine can be considered as solving a task everyday, with task training in class and validation at home. In the end, when graduate from school, we not only obtain specific knowledge, but learn how to learn as well, which is the goal of education after all. Meta-learning is a paradigm in artificial intelligence that mimics such learning procedure. By leveraging experience from previous tasks, it aims to be able to solve a new task by fast adapting to a few training data.

>tl;dr: we formalize a meta-overfitting problem that potentially hampers fast adaptation of many meta-learning algorithms, and we propose a solution to prevent this pitfall.

## Basics
To set things up, we assume there are multiple tasks generated from a task distribution $p(\mathcal{T})$. Each task has some labeled training data $\mathcal{D} = (X,Y)$ and test data $\mathcal{D}^{\star} = (X^{\star},Y^{\star})$.  $\mathcal{M}$ represents all the meta-training data and $\mathcal{T}\_j$ is a new task. The meta-learner is trained on $\mathcal{M}$, adapted on the new task training data $\mathcal{D}_{j},$ and aims to make good predictions on the new task test inputs $X^{\star}\_{j}$. This process can be summarized in a hierarchical graphical model:
<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/graph3.png" alt="drawing" width="320"/>
</center>

## Memorization Problem
Let's come back to the student example at the beginning. The daily study at school can be considered as a task in meta-training, and we assume the student learn to solve one type of math problem each day. After a period, assume all types of required problems have been repeated several times in class $($like what we once did for an important exam 💆$)$. If a student can remember all types of problems, he/she does not need to attend the class and can answer the homework questions of these types correctly. Though such seemingly innocuous memorization approach can solve new problems of the known types, however, when the student faces an unseen type of problem, he/she cannot solve it without learning from new resources.

Let's consider another illustrative example.  Assume each task is a 1D regression on some related data. In the following figures, a meta-learning algorithm is trained to adapt on a few training data, as the red points, and to fit on the validation data, as the blue points, where the dashed line represents a good adapted model 


<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/s1.png" alt="drawing" width="850"/>
</center>


By training on multiple correlated tasks, the model develops a fast adaptation ability, which can generalize to solving tasks that are unseen in the meta-training, as the left figure below. However, we find if the meta-learner is flexible enough, a single model can solve all the training tasks without adapting to the task training data, as the right figure below. In the test-time, when facing a new task, the algorithm will not know how to utilize a few task training data to infer the local parameters and therefore cannot solve the new task.

<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/s2.png" alt="drawing" width="550"/>
</center>


We call this phenomenon as the $($complete$)$ memorization problem in meta-learning and formally define it as
 
$$I(\hat{y}^{\star};\mathcal{D} | x^{\star}, \mathcal{M})=0$$

which means the predicted label and the task training data are conditionally independent.


Notice the memorization problem is closely related to the task distribution. We find that if the meta-training tasks are *mutually exclusive*, which means a single model cannot solve all the tasks, the memorization problem will not happen. For example, in the few-shot classification problems, mutually exclusive tasks are created by randomly shuffling the labels across tasks. However, in a wide range of problems the tasks are non-mutually exclusive. Therefore, the memorization problem widely exist and can influence many meta-learning algorithms.


## Meta-Regularization
Based on the above analysis and the graphical model, we find that the information that is used to predict the task test labels comes from the meta-traing data $\mathcal{M}$, task training data $\mathcal{D}$ and task test input $x^\star$. Hence, if we can limit the information that flows from $\mathcal{M}$ and $x^\star$, and in the meantime ask for accurate predictions, we can encourage the model to use the information in $\mathcal{D}$ rather than ignoring it. Using the inequalities in information and PAC-Bayes theory, one approach to the meta-regularization we derived is based on the information bottleneck, which regularizes

$$D_{KL}(q(z^\star | x^\star, \theta)||r(z^\star ))$$

The other approach is to regularize

$$D_{KL}(q(\theta | \mathcal{M})||r(\theta))$$

where $\theta$ are the parameters of an encoder: $x \to z$. Notice we should only regularize the parameters that are not used in the adaptation, which differs from stardand regularizations. Combining the meta-regularization with the objectives in Model Agnostic Meta-Learning $($MAML$)$ and Conditional Neural Process $($CNP$)$, we name our proposed new algorithms as MR-MAML and MR-CNP. We apply them to several datasets where the tasks are non-mutually exclusive, where the standard meta-learning algorithms can fail. The algorithms are tested on a pose prediction dataset where the goal is to predict the orientations of 3D objects by looking at their 2D images. Our methods outperform the compared methods by a large margin

<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/ee2.png" alt="drawing" width="750"/>
</center>

We test on the non-mutually exclusive few-shot classification problems, for which standard meta-learning methods can even give near random predictions in some cases. Our methods provide a remedy.
<center>
<img src="https://raw.githubusercontent.com/mingzhang-yin/mingzhang-yin.github.io/master/assets/images/figure_memo/ee3.png" alt="drawing" width="750"/>
</center>

## Takeaways
* Memorization is a prevalent problem in many meta-learning applications and algorithms  
* Memorization problem is a task-level overfitting problem; it differs from standard datapoint-level overfitting. The model can generalize to *new points* within a training task, but cannot generalize to a *new task*
* Meta-regularization can effectively control the memorization problem, which expands the meta-learning to the domains that it was once hard to be effective on
* 👉 Keep calm and remain adaptive!

Thanks to the collaborations of Drs. George Tucker, Mingyuan Zhou, Sergey Levine and Chelsea Finn













