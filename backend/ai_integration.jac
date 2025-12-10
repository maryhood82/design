# AI Integration Utilities

::py::
import os
import requests
from datetime import datetime
from dotenv import load_dotenv
from byllm.lib import Image, Model
::py::


glob env_loaded = load_dotenv();
    
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);


# Comprehensive article extraction from URL
obj ArticleFromURL {
    has title: str;
    has content: str;
    has source_url: str;
    has author: str;
    has published_date: str;
    has bias_category: str;
    has topic: str;
    has language: str;
    has summary: str;
    has credibility_score: float;
    has confidence: float;
    has key_claims: list[str];
    has sources_cited: list[str];
}

sem ArticleFromURL = '''
Extract comprehensive article details from the provided URL text with full context:
- title: The main headline or title of the article
- content: Complete article text with all paragraphs and context
- source_url: The original URL source
- author: Author name(s) if available
- published_date: Publication date in ISO format
- bias_category: General bias (factual, balanced, subjective influence, unbalanced, unfair, misleading, false, unknown)
- topic: Primary topic/category (politics, health, technology, etc.)
- language: Detected language code (en, es, fr, etc.)
- summary: Concise 2-3 sentence summary capturing main points
- credibility_score: Score from 0.0-1.0 based on source reputation, fact-checking, citations
- confidence: AI confidence in the extraction (0.0-1.0)
- key_claims: List of main factual claims made in the article
- sources_cited: List of sources referenced in the article
''';

# Article extraction from plain text
obj ArticleFromText {
    has title: str;
    has content: str;
    has source: str;
    has bias_category: str;
    has topic: str;
    has language: str;
    has summary: str;
    has credibility_score: float;
    has confidence: float;
    has key_claims: list[str];
    has sentiment: str;
}

sem ArticleFromText = '''
Extract article details from plain text with full contextual analysis:
- title: Extract or generate appropriate title from content
- content: Full article text preserving all context and nuance
- source: Identify source publication/website if mentioned
- bias_category: General bias (factual, balanced, subjective influence, unbalanced, unfair, misleading, false, unknown)
- topic: Primary subject matter category
- language: ISO language code
- summary: Comprehensive summary preserving key context
- credibility_score: Assessment score 0.0-1.0 based on writing quality, sources, claims
- confidence: AI confidence level in extraction (0.0-1.0)
- key_claims: Main factual assertions made
- sentiment: Overall tone (positive, negative, neutral, mixed)
''';

# Article extraction from image (OCR)
obj ArticleFromImage {
    has title: str;
    has content: str;
    has source: str;
    has bias_category: str;
    has category: str;
    has language: str;
    has summary: str;
    has credibility_score: float;
    has confidence: float;
    has ocr_quality: str;
    has image_type: str;
    has key_points: list[str];
}

sem ArticleFromImage = '''
Extract article details from image using OCR with full context preservation:
- title: Extract visible headline/title from image
- content: Complete OCR text extraction maintaining layout context
- source: Identify visible source/publication name
- bias_category: General bias (factual, balanced, subjective influence, unbalanced, unfair, misleading, false, unknown)
- category: Content type (news article, social media post, infographic, screenshot, etc.)
- language: Detected language from OCR text
- summary: Contextual summary of extracted content
- credibility_score: Score 0.0-1.0 based on visual indicators, source, content quality
- confidence: OCR and extraction confidence (0.0-1.0)
- ocr_quality: Quality assessment (high, medium, low)
- image_type: Type of image (article screenshot, social media, document, etc.)
- key_points: Main points or claims visible in image
''';

# Comprehensive article analysis
obj ArticleAnalysis {
    has summary: str;
    has bias_category: str;
    has credibility_score: float;
    has misinformation_risk: float;
    has sentiment: str;
    has key_topics: list[str];
    has key_claims: list[str];
    has factual_accuracy: float;
    has source_quality: str;
    has recommendation: str;
    has alerts: list[str];
}

sem ArticleAnalysis = '''
Perform comprehensive analysis of article content with full context:
- summary: Detailed summary preserving key context and nuance
- bias_category: General bias classification (factual, balanced, subjective influence, unbalanced, unfair, misleading, false, unknown)
- credibility_score: Overall credibility (0.0-1.0) based on sources, claims, writing
- misinformation_risk: Risk level (0.0-1.0) of containing false/misleading info
- sentiment: Overall emotional tone and framing
- key_topics: Main subjects and themes discussed
- key_claims: List of primary factual claims that can be verified
- factual_accuracy: Assessment of verifiable claims (0.0-1.0)
- source_quality: Quality rating (high, medium, low) based on journalistic standards
- recommendation: Action recommendation (trust, verify, caution, reject)
- alerts: List of specific concerns or red flags identified
''';

# Extraction Functions

def extract_article_from_url(
    text: str
) -> ArticleFromURL by llm();

def extract_article_from_text(
    text: str
) -> ArticleFromText by llm();

def extract_article_from_image_file(
    image_path: str
) -> ArticleFromImage by llm(incl_image=image_path);

def analyze_article_with_ai(
    article_text: str
) -> ArticleAnalysis by llm();

# Analysis

def summarize_article(
    article_text: str
) -> str by llm(
    method="Provide a comprehensive 3-4 sentence summary that captures the main points, context, and key arguments of the article."
);

def classify_article_bias(
    article_text: str
) -> str by llm(
    method="Classify the general bias as: factual, balanced, subjective influence, unbalanced, unfair, misleading, false, or unknown. Consider language framing, source selection, and narrative choices. Provide reasoning for classification."
);

def detect_article_language(
    article_text: str
) -> str by llm(
    method="Detect the primary language and return ISO language code (e.g., 'en', 'es', 'fr')."
);

def evaluate_article_credibility(
    article_text: str
) -> float by llm(
    method="Evaluate credibility on scale 0.0-1.0 based on: source citations, factual claims, writing quality, logical consistency, and evidence quality. Return only the numeric score."
);

def score_article_misinformation(
    article_text: str
) -> float by llm(
    method="Assess misinformation risk on scale 0.0-1.0 based on: false claims, misleading framing, lack of sources, logical fallacies, and emotional manipulation. Return only the numeric score."
);

def generate_article_alerts(
    article_text: str
) -> list[str] by llm(
    method="Identify specific red flags or concerns: unverified claims, misleading statistics, biased framing, missing context, logical fallacies, emotional manipulation. Return as list of alert strings."
);

def extract_keywords_from_article(
    article_text: str
) -> list[str] by llm(
    method="Extract 5-10 most relevant keywords and key phrases that capture the article's main topics and themes."
);

def answer_natural_language_query(
    query: str,
    context: str
) -> str by llm(
    method="Answer the user's question based on the provided article context. Be specific and cite relevant parts of the article."
);

def generate_article_title(
    article_text: str
) -> str by llm(
    method="Generate a clear, accurate headline that captures the main point of the article in 8-12 words."
);

def detect_misinformation_in_article(
    article_text: str
) -> dict by llm(
    method="Analyze for misinformation and return: {risk_score: float (0.0-1.0), issues_found: list[str], severity: str (low/medium/high/critical), recommendation: str}"
);

#Utility

def validate_credibility_score(score: float) -> float {
    
    if score < 0.0 {
        return 0.0;
    }
    if score > 1.0 {
        return 1.0;
    }
    return score;
}

def format_bias_category(bias: str) -> str {
   
    bias_lower = bias.lower().strip();
    valid_categories = ["factual", "balanced", "subjective influence", "unbalanced", "unfair", "misleading", "false", "unknown"];
    
    if bias_lower in valid_categories {
        return bias_lower;
    }
    return "unknown";
}
