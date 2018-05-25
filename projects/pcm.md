---
layout: project
title: "Phylogenetic comparative methods"
author: Randi H. Griffin
comments: true
---

___

This project includes my methodological research on a pair of phylogenetic comparative methods that aim to estimate ancestral states for continuous traits. These methods were recently developed by Jeroen B Smaers (JBS), and they have gained some traction over the last few years, appearing in 11 combined publications as of May 10, 2017 (they are listed in the Appendix at the bottom of this page).

I have found that these methods are highly unprincipled and do not do what they claim to do. An addition, the simulation studies that purport to validate these methods were seriously flawed and produced misleading results. 

Below is a timeline and summary of papers relevant to this project, including 3 written by JBS and 2 written by myself. My papers include reproducible simulation studies, linked to below.

___

### First method: Independent Evolution

**Smaers & Vinicius (2009)** - [download](/assets/pdfs/Smaers&Vinicius_2009.pdf)

This paper presents a method called Independent Evolution (IE), which is designed to estimate ancestral states and an independent rate of evolution for a continuous trait on every branch of a phylogeny. The method first computes point estimates of ancestral states using an algorithm, and then computes something similar to ancestor-descendent contrasts to represent 'rates of evolution' on each branch. The authors recommend plotting rates of evolution for one trait against another to reveal novel information about relative rates of evolution. 

**Griffin & Yapuncich (2015)** - [download](/assets/pdfs/Griffin&Yapuncich_2015.pdf)

We critique IE and present simulation results to support our arguments. We show that 1) equations used to compute ancestral state estimates are biased towards increasingly positive values near the root of the tree, 2) IE branch-specific rates of evolution bare little relationship to the simulated rates of evolution due to the problematic equations used to compute them, and 3) regressing ancestor-descendent contrasts for one trait against another (which has been done several times, most notably <a target="_blank" href="http://www.pnas.org/content/109/44/18006.short">here</a>) simply estimates the evolutionary regression coefficient, the same parameter estimated by Phylogenetically Independent Contrasts and PGLS, but it does so with bias and with inflated confidence because the ancestor-descendent contrasts include redundant information.
<a target="_blank" href="https://github.com/rgriff23/Evaluating_IE">Go to simulations</a>

JBS declined to respond to this critique.

### Second method: 'multiple variance Brownian motion'

**Smaers, Mongle, & Kandler (2016)** - [download](/assets/pdfs/Smaers_etal_2016.pdf)

This method was published shortly after our critique of the first method was published. It claims to present a 'multiple variance Brownian motion model' that reconstructs ancestral states more accurately than existing methods when a few large bursts of evolution have occurred throughout the phylogeny. The authors performed simulations to show that when data are simulated under the burst scenario, their new method produces relatively more accurate ASRs than maximum likelihood Brownian motion.

**Griffin & Yapuncich (2017)** - [download](/assets/pdfs/Griffin&Yapuncich_2017.pdf)

We argue that the method presented by Smaers et al. (2016) is inviable and highlight major problems with its conception and presentation. The method is not actually a 'multiple variance Brownian motion model', as the name and verbal description of the method implies. Based on the code and the mathematical description, the method is an algorithm that adjusts phylogenetic branch lengths to provide a closer fit to a dataset in a rather arbitrary way, and then estimates Brownian motion ancestral states on the adjusted phylogeny. The equations used to adjust phylogenetic branch lengths are extremely unprincipled, and there is no reason why this approach should improve the accuracy of ancestral state estimates in general. JBS et al. simulated extreme evolutionary scenarios (dramatic bursts of evolutionary change on a few branches of the tree) and demonstrated that their method produces more accurate ancestral states than simple Brownian motion models, but they presented results in a way that obscures the fact that their estimated ancestral states are extremely inaccurate and they neglected to test their method against models that are designed to handle the extreme scenarios they simulated. <a target="_blank" href="https://github.com/rgriff23/Evaluating_mvBM">Go to simulations</a>

**Smaers & Mongle (2017)** - [download](/assets/pdfs/Smaers&Mongle2017.pdf)

JBS responds to our critique with 10 pages of smoke and mirrors.

___

### Appendix: Papers that have used these methods (last updated May 10, 2017)

**Independent Evolution (Smaers & Vinicius 2009)**

1. Smaers JB, Dechmann DKN, Goswami A, Soligo C, Safi K. 2012. Comparative analyses of evolutionary rates reveal different pathways to encephalization in bats, carnivorans, and primates. *Proceedings of the National Academy of Sciences* 109: 18006–18011. doi: 10.1073/pnas.1212181109 PMID: 23071335 <a target="_blank" href="http://www.pnas.org/content/109/44/18006.short">link</a>

2. Smaers JB, Steele J, Zilles K. 2011. Modeling the evolution of cortico-cerebellar systems in primates. *Ann NY Acad Sci.* 1225: 176–190. doi: 10.1111/j.1749-6632.2011.06003.x PMID: 21535004 <a target="_blank" href="https://onlinelibrary.wiley.com/doi/10.1111/j.1749-6632.2011.06003.x/full">link</a>

3. Smaers JB, Steele J, Case CR, Amunts K. 2013. Laterality and the evolution of the prefronto-cerebellar system in anthropoids. *Ann NY Acad Sci.* 1822: 59–69. <a target="_blank" href="http://onlinelibrary.wiley.com/doi/10.1111/nyas.12047/full">link</a>

4. Smaers JB, Soligo C. 2013. Brain reorganization, not relative brain size, primarily characterizes anthropoid brain evolution. *Proc Biol Sci.* 280: 20130269. doi: 10.1098/rspb.2013.0269 PMID: 23536600 <a target="_blank" href="http://rspb.royalsocietypublishing.org/content/280/1759/20130269.short">link</a>

5. Tsegai ZJ, Kivell TL, Gross T, Nguyen NH, Pahr DH, Smaers JB, et al. 2013. Trabecular bone structure correlates with hand posture and use in hominoids. *PLoS One.* 8: e78781. doi: 10.1371/journal.pone.0078781 PMID: 24244359 <a target="_blank" href="http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0078781">link</a>

6. Kivell TL, Barros AP, Smaers JB. 2013. Different evolutionary pathways underlie the morphology of wrist bones in hominoids. *BMC Evolutionary Biology.* 13: 229. doi: 10.1186/1471-2148-13-229 PMID: 24148262 <a target="_blank" href="https://bmcevolbiol.biomedcentral.com/articles/10.1186/1471-2148-13-229">link</a>

7. Goswami A, Smaers JB, Soligo C, Polly PD. 2014. The macroevolutionary consequences of phenotypic integration: from development to deep time. *Proc Biol Soc.* 369: 20130254. <a target="_blank" href="http://rstb.royalsocietypublishing.org/content/369/1649/20130254.short">link</a>

8. Jones KE, Smaers JB, Goswami A. 2015. Impact of the terrestrial-aquatic transition on disparity and rates of evolution in the carnivoran skull. *BMC Evolutionary Biology.* 15: 8. doi: 10.1186/s12862-015-0285-5 PMID: 25648618 <a target="_blank" href="https://bmcevolbiol.biomedcentral.com/articles/10.1186/s12862-015-0285-5">link</a>

9. Gignac P, O’Brien H. 2016. Suchian feeding success at the interface of ontogeny and macroevolution. *Integrative and comparative biology* 56(3): 449-458. <a target="_blank" href="https://academic.oup.com/icb/article/56/3/449/2363212/Suchian-Feeding-Success-at-the-Interface-of">link</a>

**multiple variance Brownian motion (Smaers et al., 2015)**

1. Gignac P, O’Brien H. 2016. Suchian feeding success at the interface of ontogeny and macroevolution. *Integrative and comparative biology* 56(3): 449-458. <a target="_blank" href="https://academic.oup.com/icb/article/56/3/449/2363212/Suchian-Feeding-Success-at-the-Interface-of">link</a>

2. Gómez-Robles A, Smaers JB, Holloway RL, Polly PD, Wood BA. 2017. Brain enlargement and dental reduction were not linked in hominin evolution. *Proceedings of the National Academy of Sciences*: 201608798. <a target="_blank" href="http://www.pnas.org/content/114/3/468.abstract">link</a>

3. Smaers JB, Gómez-Robles A, Parks AN, Sherwood CC. 2017. Exceptional evolutionary expansion of prefrontal cortex in great apes and humans. *Current Biology* 27(5): 714-720. <a target="_blank" href="http://www.cell.com/current-biology/fulltext/S0960-9822(17)30020-9?_returnURL=http%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS0960982217300209%3Fshowall%3Dtrue&cc=y=">link</a>

___
